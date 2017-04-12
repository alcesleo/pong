require "gosu"
require "./lib/point"
require "./lib/paddle"
require "./lib/ball"
require "./lib/collision"
require "./lib/computer_player"
require "./lib/scoreboard"

class Pong < Gosu::Window
  BACKGROUND_COLOR = Gosu::Color::BLACK
  FOREGROUND_COLOR = Gosu::Color::WHITE

  BALL_SIZE             = 40
  PADDLE_HEIGHT         = 100
  PADDLE_MARGIN         = 10
  PADDLE_SPEED_COMPUTER = 5
  PADDLE_SPEED_PLAYER   = 10
  PADDLE_WIDTH          = 20

  def initialize
    super(640, 480)
    self.caption = "Pong"

    @left_paddle     = Paddle.new(position: left_paddle_starting_position, height: PADDLE_HEIGHT, width: PADDLE_WIDTH, window_height: height, movement_speed: PADDLE_SPEED_PLAYER)
    @right_paddle    = Paddle.new(position: right_paddle_starting_position, height: PADDLE_HEIGHT, width: PADDLE_WIDTH, window_height: height, movement_speed: PADDLE_SPEED_COMPUTER)
    @ball            = Ball.new(size: BALL_SIZE, window_height: height, window_width: width)
    @collision       = Collision.new(left_paddle: left_paddle, right_paddle: right_paddle, ball: ball, height: height, width: width)
    @computer_player = ComputerPlayer.new(paddle: right_paddle, ball: ball)
    @scoreboard      = Scoreboard.new(ball: ball, window_width: width, callback: method(:reset_ball))
  end

  def update
    move_player_paddle
    move_computer_paddle
    move_ball
    detect_collisions
    keep_score
  end

  def draw
    draw_background
    draw_paddles
    draw_ball
    draw_scoreboard
  end

  def button_down(key)
    case key
    when Gosu::KbQ then close
    when Gosu::KbR then initialize
    end
  end

  def needs_cursor?
    true
  end

  private

  attr_reader :left_paddle, :right_paddle, :ball, :collision, :computer_player, :scoreboard

  def reset_ball
    ball.reset
  end

  def move_player_paddle
    left_paddle.move_up if button_down?(Gosu::KbUp)
    left_paddle.move_down if button_down?(Gosu::KbDown)
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
    scoreboard.call
  end

  def draw_background
    Gosu.draw_rect(0, 0, width, height, BACKGROUND_COLOR)
  end

  def draw_paddles
    Gosu.draw_rect(left_paddle.position.x, left_paddle.position.y, left_paddle.width, left_paddle.height, FOREGROUND_COLOR)
    Gosu.draw_rect(right_paddle.position.x, right_paddle.position.y, right_paddle.width, right_paddle.height, FOREGROUND_COLOR)
  end

  def draw_ball
    Gosu.draw_rect(ball.position.x, ball.position.y, ball.size, ball.size, FOREGROUND_COLOR)
  end

  def draw_scoreboard
    font.draw(scoreboard.left_score, (width / 3) - 20, 50, 0)
    font.draw(scoreboard.right_score, ((width / 3) * 2) - 20, 50, 0)
  end

  def font
    @_font ||= Gosu::Font.new(self, "Arial", 70)
  end

  def left_paddle_starting_position
    Point.new(
      x: PADDLE_MARGIN,
      y: (height / 2) - (PADDLE_HEIGHT / 2),
    )
  end

  def right_paddle_starting_position
    Point.new(
      x: (width - PADDLE_MARGIN - PADDLE_WIDTH),
      y: (height / 2) - (PADDLE_HEIGHT / 2),
    )
  end
end

Pong.new.show
