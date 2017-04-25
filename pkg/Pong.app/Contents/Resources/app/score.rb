class Score
  attr_reader :left_score, :right_score

  def initialize(ball:, boundary_width:, callback: Proc.new)
    @ball           = ball
    @boundary_width = boundary_width
    @callback       = callback
    @left_score     = 0
    @right_score    = 0
  end

  def call
    self.right_score += 1 and callback.call if in_left_goal?
    self.left_score += 1 and callback.call if in_right_goal?
  end

  private

  attr_reader :ball, :boundary_width, :callback
  attr_writer :left_score, :right_score

  def in_left_goal?
    ball.position.x <= 0
  end

  def in_right_goal?
    ball.position.x + ball.size >= boundary_width
  end
end
