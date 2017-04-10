class Paddle
  attr_reader :position, :height, :width, :window_height, :window_width, :movement_speed

  def initialize(side:, margin:, height: 100, width: 20, window_height:, window_width:, movement_speed: 10)
    @height         = height
    @width          = width
    @window_height  = window_height
    @window_width   = window_width
    @movement_speed = movement_speed
    @position       = starting_position(side, margin)
  end

  def move_up
    self.position.y -= movement_speed unless position.y <= 0
  end

  def move_down
    self.position.y += movement_speed unless position.y >= window_height - height
  end

  private

  attr_writer :position

  def starting_position(side, margin)
    Point.new(
      x: side == :left ? margin : (window_width - margin - width),
      y: (window_height / 2) - (height / 2)
    )
  end
end
