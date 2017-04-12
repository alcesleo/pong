class Paddle
  attr_reader :position, :height, :width, :boundary_height, :movement_speed

  def initialize(position:, height: 100, width: 20, boundary_height:, movement_speed: 10)
    @position        = position
    @height          = height
    @width           = width
    @boundary_height = boundary_height
    @movement_speed  = movement_speed
  end

  def move_up
    position.y -= movement_speed unless position.y <= 0
  end

  def move_down
    position.y += movement_speed unless position.y >= boundary_height - height
  end

  private

  attr_writer :position
end
