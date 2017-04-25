class Ball
  attr_accessor :size, :position, :velocity

  def initialize(size:, position:, velocity:)
    @size     = size
    @position = position
    @velocity = velocity
  end

  alias height size
  alias width size

  def call
    position.x += velocity.x
    position.y += velocity.y
  end

  def bounce_paddle
    velocity.x *= -1
  end

  def bounce_wall
    velocity.y *= -1
  end
end
