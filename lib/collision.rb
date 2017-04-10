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

  def detect_walls
    if ball.position.y <= 0 || ball.position.y >= height - ball.size
      ball.bounce_wall
    end
  end

  def detect_paddles
    detect_right_paddle
    detect_left_paddle
  end

  def detect_left_paddle
    hit_paddle_y = ball.position.y.between?(left_paddle.position.y - ball.size, left_paddle.position.y + left_paddle.height + ball.size)
    hit_paddle_x = ball.position.x.between?(left_paddle.position.x, left_paddle.position.x + left_paddle.width)
    going_left   = ball.velocity.x < 0

    if going_left && hit_paddle_y && hit_paddle_x
      ball.bounce_paddle
    end
  end

  def detect_right_paddle
    hit_paddle_x = ball.position.x.between?(right_paddle.position.x, right_paddle.position.x + right_paddle.width)
    hit_paddle_y = ball.position.y.between?(right_paddle.position.y - ball.size, right_paddle.position.y + right_paddle.height + ball.size)
    going_right  = ball.velocity.x > 0

    if going_right && hit_paddle_y && hit_paddle_x
      ball.bounce_paddle
    end
  end
end
