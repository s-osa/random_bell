require "random_bell/version"

class RandomBell
  attr_reader :mu, :sigma, :range, :method

  def mu=(x)
    probability_check(x, @sigma, @range)
    @mu = x
  end

  def sigma=(x)
    probability_check(@mu, x, @range)
    @sigma = x
  end

  def range=(x)
    raise(ArgumentError, "Not range object") if x.class != Range
    probability_check(@mu, @sigma, x)
    @range = x
  end

  def method=(m)
    methods = private_methods(false) - [:initialize, :probability_check]
    if methods.include?(m)
      @method = m
    else
      raise ArgumentError, "Undefined method"
    end
  end

  def renew(mu: 0.5, sigma: 0.2, range: 0.0..1.0, method: :box_muller)
    probability_check(mu, sigma, range)
    @mu    = mu
    @sigma = sigma
    @range = range
    self.method = method
    true
  end

  def initialize(mu: 0.5, sigma: 0.2, range: 0.0..1.0, method: :box_muller)
    @mu    = mu
    @sigma = sigma
    @range = range
    self.method = method
    probability_check(mu, sigma, range)
  end

  def standard
    send(@method)
  end

  def normal
    @mu + standard * @sigma
  end

  def rand
    loop do
      num = normal
      return num if @range.include?(num)
    end
  end

  def to_histogram(rows: 20, size: 10 ** 4)
    histogram = ""

    numbers = (1..size).to_a.map{ rand }

    klasses, klass_width = [], (@range.max - @range.min).to_f / rows
    (0..rows).each_cons(2) do |left, right|
      klasses << Range.new(@range.min + klass_width * left, @range.min + klass_width * right)
    end

    divider = (klasses.map{|klass| numbers.select{|num| klass.include?(num) }.size }.max / 50.0).ceil
    klasses.each do |klass|
      n = numbers.select{|num| klass.include?(num) }.size / divider
      histogram << sprintf("%+3.3f", klass.max) << ": " << "*" * n << "\n"
    end

    histogram
  end

  private

  def probability_check(mu, sigma, range)
    if    mu < range.min; x = range.min
    elsif mu > range.max; x = range.max
    else; return true
    end

    prblty = (1 / (Math.sqrt(2 * Math::PI) * sigma) * Math.exp(-((x - mu) ** 2 / (2 * sigma) ** 2 )))
    raise ArgumentError, "An appearance probability in range is too low (#{(prblty * 100).round(3)}%)" if prblty < 0.01
  end

  def box_muller
    theta  = 2 * Math::PI * Random.rand
    r      = Math.sqrt( -2 * Math.log(Random.rand) )
    z1, z2 = r * Math.cos(theta), r * Math.sin(theta)
    [z1, z2].sample
  end

  def central_limit
    arr = []
    12.times{ arr << Random.rand }
    arr.reduce(0.0, &:+) - 6
  end
end
