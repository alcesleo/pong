class Score
  attr_reader :left_score, :right_score

  def initialize(ball:, window_width:, callback: Proc.new)
    @ball         = ball
    @window_width = window_width
    @callback     = callback
    @left_score   = 0
    @right_score  = 0
  end

  def call
    if ball.position.x <= 0
      self.right_score += 1
      callback.call
    elsif ball.position.x + ball.size >= window_width
      self.left_score += 1
      callback.call
    end
  end

  private

  attr_reader :ball, :window_width, :callback
  attr_writer :left_score, :right_score
end
