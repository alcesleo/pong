class ComputerPlayer
  attr_reader :paddle, :ball

  def initialize(paddle:, ball:)
    @paddle = paddle
    @ball   = ball
  end

  def call
    if paddle.position.y > ball.position.y
      paddle.move_up
    elsif paddle.position.y + paddle.height < ball.position.y + ball.size
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
