require "./lib/paddle"

class Game
  PADDLE_HEIGHT         = 100
  PADDLE_MARGIN         = 10
  PADDLE_SPEED_COMPUTER = 5
  PADDLE_SPEED_PLAYER   = 10
  PADDLE_WIDTH          = 20

  attr_reader :window_width, :window_height

  def initialize(window_width, window_height)
    @window_width = window_width
    @window_height = window_height
  end

  def player_paddle
    @_player_paddle ||= Paddle.new(
      height:         PADDLE_HEIGHT,
      width:          PADDLE_WIDTH,
      movement_speed: PADDLE_SPEED_PLAYER,
      window_height:  window_height,
      position:       Point.new(x: paddle_left_position, y: paddle_vertical_center_position),
    )
  end

  def computer_paddle
    @_computer_paddle ||= Paddle.new(
      height:         PADDLE_HEIGHT,
      width:          PADDLE_WIDTH,
      movement_speed: PADDLE_SPEED_COMPUTER,
      window_height:  window_height,
      position:       Point.new(x: paddle_right_position, y: paddle_vertical_center_position),
    )
  end

  def paddle_vertical_center_position
    (window_height / 2) - (PADDLE_HEIGHT / 2)
  end

  def paddle_left_position
    PADDLE_MARGIN
  end

  def paddle_right_position
    (window_width - PADDLE_MARGIN - PADDLE_WIDTH)
  end
end
