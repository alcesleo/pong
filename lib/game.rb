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

  def ball
    @_ball ||= Ball.new(size: BALL_SIZE, position: ball_center_position, velocity: ball_random_velocity)
  end

  def collision
    @_collision ||= Collision.new(
      left_paddle:  player_paddle,
      right_paddle: computer_paddle,
      ball:         ball,
      height:       window_height,
      width:        window_width,
    )
  end

  def computer_player
    @_computer_player = ComputerPlayer.new(paddle: computer_paddle, ball: ball)
  end

  def score
    @_score = Score.new(ball: ball, window_width: window_width, callback: method(:reset_ball))
  end

  def reset_ball
    ball.position = ball_center_position
    ball.velocity = ball_random_velocity
  end

  private

  def paddle_vertical_center_position
    (window_height / 2) - (PADDLE_HEIGHT / 2)
  end

  def paddle_left_position
    PADDLE_MARGIN
  end

  def paddle_right_position
    (window_width - PADDLE_MARGIN - PADDLE_WIDTH)
  end

  def ball_random_velocity
    velocity = Point.new(
      x: rand(5..10),
      y: rand(5..10),
    )
    velocity = velocity.invert_y if rand > 0.5
    velocity = velocity.invert_x if rand > 0.5
    velocity
  end

  def ball_center_position
    Point.new(
      x: (window_width / 2) - (BALL_SIZE / 2),
      y: (window_height / 2) - (BALL_SIZE / 2),
    )
  end
end
