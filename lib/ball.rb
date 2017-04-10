require "./lib/point"

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
