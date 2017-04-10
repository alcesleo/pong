class Collision
  attr_reader :left_paddle, :right_paddle, :ball, :window_dimensions

  def initialize(left_paddle:, right_paddle:, ball:, height:, width:)
    @left_paddle  = left_paddle
    @right_paddle = right_paddle
    @ball         = ball
    @window       = window
  end

  def call
    if ball.position.y <= 0 || ball.position.y >= height - ball.size
      ball.bounce_wall
    end
  end
end
