class Point
  attr_accessor :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def +(other)
    Point.new(x: x + other.x, y: y + other.y)
  end

  def invert_y
    Point.new(x: x, y: -y)
  end

  def invert_x
    Point.new(x: -x, y: y)
  end
end
