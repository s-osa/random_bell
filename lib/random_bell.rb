require "random_bell/version"

class RandomBell
  def initialize(mu: 0.5, sigma: 0.2, range: 0.0..1.0, method: :box_muller)
    @mu     = mu
    @sigma  = sigma
    @range  = range
    @method = method
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
    (0..rows).each_cons(2) do |min, max|
      klasses << Range.new(klass_width * min, klass_width * max)
    end

    divider = (klasses.map{|klass| numbers.select{|num| klass.include?(num) }.size }.max / 50.0).ceil
    klasses.each do |klass|
      n = numbers.select{|num| klass.include?(num) }.size / divider
      histogram << sprintf("%+3.3f", klass.max) << ": " << "*" * n << "\n"
    end

    histogram
  end

  private

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
