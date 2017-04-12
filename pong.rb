require "gosu"
require "./lib/game"

class Pong < Gosu::Window
  BACKGROUND_COLOR = Gosu::Color::BLACK
  FOREGROUND_COLOR = Gosu::Color::WHITE

  WINDOW_WIDTH  = 640
  WINDOW_HEIGHT = 480
  WINDOW_TITLE  = "Pong"

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = WINDOW_TITLE

    @game = Game.new(width, height)

    @left_paddle     = game.player_paddle
    @right_paddle    = game.computer_paddle
    @ball            = game.ball
    @collision       = game.collision
    @computer_player = game.computer_player
    @score           = game.score
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
    draw_score
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

  attr_reader :left_paddle, :right_paddle, :ball, :collision, :computer_player, :score, :game

  def reset_ball
    game.reset_ball
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
    score.call
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

  def draw_score
    font.draw(score.left_score, (width / 3) - 20, 50, 0)
    font.draw(score.right_score, ((width / 3) * 2) - 20, 50, 0)
  end

  def font
    @_font ||= Gosu::Font.new(self, "Arial", 70)
  end
end

Pong.new.show
