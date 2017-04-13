require "./lib/ball"
require "./lib/collision"
require "./lib/computer_player"
require "./lib/paddle"
require "./lib/point"
require "./lib/score"

class Game
  PADDLE_HEIGHT         = 100
  PADDLE_MARGIN         = 10
  PADDLE_SPEED_COMPUTER = 5
  PADDLE_SPEED_PLAYER   = 10
  PADDLE_WIDTH          = 20
  BALL_SIZE             = 40

  attr_reader :boundary_width, :boundary_height

  def initialize(boundary_width:, boundary_height:)
    @boundary_width  = boundary_width
    @boundary_height = boundary_height
  end

  def tick
    move_ball
    move_computer_paddle
    detect_collisions
    keep_score
  end

  def move_player_paddle_up
    player_paddle.move_up
  end

  def move_player_paddle_down
    player_paddle.move_down
  end

  def move_computer_paddle
    computer_player.call
  end

  def move_ball
    ball.call
  end

  def detect_collisions
    collision.call
  end

  def keep_score
    score.call
  end

  def player_paddle
    @_player_paddle ||= Paddle.new(
      height:          PADDLE_HEIGHT,
      width:           PADDLE_WIDTH,
      movement_speed:  PADDLE_SPEED_PLAYER,
      boundary_height: boundary_height,
      position:        Point.new(x: paddle_left_position, y: paddle_vertical_center_position),
    )
  end

  def computer_paddle
    @_computer_paddle ||= Paddle.new(
      height:          PADDLE_HEIGHT,
      width:           PADDLE_WIDTH,
      movement_speed:  PADDLE_SPEED_COMPUTER,
      boundary_height: boundary_height,
      position:        Point.new(x: paddle_right_position, y: paddle_vertical_center_position),
    )
  end

  def ball
    @_ball ||= Ball.new(size: BALL_SIZE, position: ball_center_position, velocity: ball_random_velocity)
  end

  def collision
    @_collision ||= Collision.new(
      left_paddle:  player_paddle,
      right_paddle: computer_paddle,
      ball:         ball,
      height:       boundary_height,
      width:        boundary_width,
    )
  end

  def computer_player
    @_computer_player = ComputerPlayer.new(paddle: computer_paddle, ball: ball)
  end

  def score
    @_score ||= Score.new(ball: ball, boundary_width: boundary_width, callback: method(:reset_ball))
  end

  private

  def reset_ball
    ball.position = ball_center_position
    ball.velocity = ball_random_velocity
  end

  def paddle_vertical_center_position
    (boundary_height / 2) - (PADDLE_HEIGHT / 2)
  end

  def paddle_left_position
    PADDLE_MARGIN
  end

  def paddle_right_position
    (boundary_width - PADDLE_MARGIN - PADDLE_WIDTH)
  end

  def ball_random_velocity
    Point.new(
      x: random_number(5, 10),
      y: random_number(5, 10),
    )
  end

  def ball_center_position
    Point.new(
      x: (boundary_width / 2) - (BALL_SIZE / 2),
      y: (boundary_height / 2) - (BALL_SIZE / 2),
    )
  end

  def random_number(low_abs, high_abs)
    result = 0
    result = rand(-high_abs..high_abs) until result.abs > low_abs
    result
  end
end
