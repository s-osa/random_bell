project_root = File.join(File.dirname(__FILE__), '..')
$: << project_root

require 'lib/random_bell'

class Array
  def average
    reduce(0.0, &:+) / size
  end

  def variance
    avg = average
    reduce(0.0){|sum, f| sum += ( f - avg ) ** 2 } / size
  end

  def standard_diviation
    Math.sqrt(variance)
  end
end
