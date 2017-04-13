class Collision
  attr_reader :left_paddle, :right_paddle, :ball, :height, :width

  def initialize(left_paddle:, right_paddle:, ball:, height:, width:)
    @left_paddle  = left_paddle
    @right_paddle = right_paddle
    @ball         = ball
    @height       = height
    @width        = width
  end

  def call
    detect_walls
    detect_paddles
  end

  private

  def intersects?(rect1, rect2)
    rect1.position.x   <= rect2.position.x + rect2.width &&
      rect2.position.x <= rect1.position.x + rect1.width &&
      rect1.position.y <= rect2.position.y + rect2.height &&
      rect2.position.y <= rect1.position.y + rect1.height
  end

  def detect_walls
    ball.bounce_wall if ball.position.y <= 0 || ball.position.y + ball.size >= height
  end

  def detect_paddles
    ball.bounce_paddle if hit_left_paddle || hit_right_paddle
  end

  def hit_left_paddle
    intersects?(left_paddle, ball) && ball.velocity.x < 0
  end

  def hit_right_paddle
    intersects?(right_paddle, ball) && ball.velocity.x > 0
  end
end
