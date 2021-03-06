require "random_bell/version"

class RandomBell
  # @param mu     [Float]
  # @param sigma  [Float]
  # @param range  [Range]
  # @param seed   [Integer]
  # @param method [Symbol] Method to generate standard normal distribution (:box_muller or :central_limit)
  def initialize(mu: 0.5, sigma: 0.2, range: 0.0..1.0, seed: Random.new_seed, method: :box_muller)
    @mu     = mu
    @sigma  = sigma
    @range  = range
    @rand_generator = Random.new(seed)
    @method = method
  end

  # @return [Float]
  def standard
    send(@method)
  end

  # @return [Float]
  def normal
    @mu + standard * @sigma
  end

  # @return [Float]
  def rand
    loop do
      num = normal
      return num if @range.include?(num)
    end
  end

  # @return [String]
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

  # @return [Float]
  def box_muller
    @box_muller_queue ||= []

    if @box_muller_queue.empty?
      theta  = 2 * Math::PI * random_number
      r      = Math.sqrt( -2 * Math.log(random_number) )
      z1, z2 = r * Math.cos(theta), r * Math.sin(theta)
      @box_muller_queue += [z1, z2]
    end

    @box_muller_queue.shift
  end

  # @return [Float]
  def central_limit
    arr = []
    12.times{ arr << random_number }
    arr.reduce(0.0, &:+) - 6
  end

  # @return [Float]
  def random_number
    @rand_generator.rand
  end
end
