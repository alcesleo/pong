class Paddle
  attr_reader :position, :height, :width, :window_height, :movement_speed

  def initialize(height: 100, window_height:, movement_speed: 10)
    @height         = height
    @window_height  = window_height
    @movement_speed = movement_speed
    @position       = center_position
  end

  def move_up
    self.position -= movement_speed unless position <= 0
  end

  def move_down
    self.position += movement_speed unless position >= window_height - height
  end

  private

  attr_writer :position

  def center_position
    (window_height / 2) - (height / 2)
  end
end
