class Ball
  attr_accessor :velocity, :position, :size

  def initialize(size:, position:, velocity:)
    @size     = size
    @position = position
    @velocity = velocity
  end

  alias width size
  alias height size

  def call
    self.position += velocity
  end

  def bounce_paddle
    self.velocity = velocity.invert_x
  end

  def bounce_wall
    self.velocity = velocity.invert_y
  end
end
