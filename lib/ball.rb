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
    self.position.x += velocity.x
    self.position.y += velocity.y
  end

  def bounce_paddle
    self.velocity.x = -velocity.x
  end

  def bounce_wall
    self.velocity.y = -velocity.y
  end
end
