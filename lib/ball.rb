require "./lib/point"

class Ball
  attr_reader :velocity, :position, :size, :center_position

  def initialize(size:, window_height:, window_width:, velocity: random_velocity)
    @size            = size
    @center_position = calculate_center_position(window_height, window_width)
    @position        = center_position
    @velocity        = velocity
  end

  alias_method :width, :size
  alias_method :height, :size

  def call
    self.position += velocity
  end

  def bounce_paddle
    self.velocity = velocity.invert_x
  end

  def bounce_wall
    self.velocity = velocity.invert_y
  end

  def reset
    self.position = center_position
    self.velocity = random_velocity
  end

  private

  attr_writer :velocity, :position

  def random_velocity
    velocity = Point.new(
      x: rand(5..10),
      y: rand(5..10),
    )
    velocity = velocity.invert_y if rand > 0.5
    velocity = velocity.invert_x if rand > 0.5
    velocity
  end

  def calculate_center_position(height, width)
    Point.new(
      x: (width / 2) - (size / 2),
      y: (height / 2) - (size / 2),
    )
  end
end
