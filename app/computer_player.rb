class ComputerPlayer
  attr_reader :paddle, :ball

  def initialize(paddle:, ball:)
    @paddle = paddle
    @ball   = ball
  end

  def call
    if under_ball?
      paddle.move_up
    elsif over_ball?
      paddle.move_down
    end
  end

  private

  def under_ball?
    paddle.position.y > ball.position.y
  end

  def over_ball?
    paddle.position.y + paddle.height < ball.position.y + ball.size
  end
end
