class Paddle
  attr_reader :position, :height, :width, :window_height, :movement_speed

  def initialize(position:, height: 100, width: 20, window_height:, movement_speed: 10)
    @position       = position
    @height         = height
    @width          = width
    @window_height  = window_height
    @movement_speed = movement_speed
  end

  def move_up
    self.position.y -= movement_speed unless position.y <= 0
  end

  def move_down
    self.position.y += movement_speed unless position.y >= window_height - height
  end

  private

  attr_writer :position
end
