class Point
  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y

    freeze
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

  def invert_values
    Point.new(x: -x, y: -y)
  end
end

class Ball
  attr_reader :velocity, :position, :size

  def initialize(size:, window_height:, window_width:, velocity: random_velocity)
    @size     = size
    @position = center_position(window_height, window_width)
    @velocity = velocity
  end

  def move
    self.position += velocity
  end

  def bounce_paddle
    self.velocity = velocity.invert_values
  end

  def bounce_wall
    self.velocity = velocity.invert_y
  end

  private

  attr_writer :window_width, :window_height
  attr_writer :velocity, :position

  def random_velocity
    velocity = Point.new(
      x: rand(10..20),
      y: rand(10..20),
    )
    velocity = velocity.invert_y if rand > 0.5
    velocity = velocity.invert_x if rand > 0.5
    velocity
  end

  def center_position(height, width)
    Point.new(
      x: (width / 2) - (size / 2),
      y: (height / 2) - (size / 2),
    )
  end
end
