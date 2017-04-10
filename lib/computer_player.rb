class ComputerPlayer
  attr_reader :paddle, :ball

  def initialize(paddle:, ball:)
    @paddle = paddle
    @ball   = ball
  end

  def call
    if paddle_center > ball_center
      paddle.move_up
    else
      paddle.move_down
    end
  end

  private

  def paddle_center
    paddle.position.y + (paddle.height / 2)
  end

  def ball_center
    ball.position.y + (ball.size / 2)
  end
end
