require "gosu"
require "game"

class Pong < Gosu::Window
  BACKGROUND_COLOR = Gosu::Color::BLACK
  FOREGROUND_COLOR = Gosu::Color::WHITE

  WINDOW_WIDTH  = 640
  WINDOW_HEIGHT = 480
  WINDOW_TITLE  = "Pong".freeze

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = WINDOW_TITLE

    @game = Game.new(boundary_width: width, boundary_height: height)
  end

  def update
    game.move_player_paddle_up if button_down?(Gosu::KbUp)
    game.move_player_paddle_down if button_down?(Gosu::KbDown)

    game.tick
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

  attr_reader :game

  def draw_background
    Gosu.draw_rect(0, 0, width, height, BACKGROUND_COLOR)
  end

  def draw_paddles
    draw_rectangular_element(game.player_paddle)
    draw_rectangular_element(game.computer_paddle)
  end

  def draw_ball
    draw_rectangular_element(game.ball)
  end

  def draw_score
    font.draw(game.score.left_score, (width / 3) - 20, 50, 0)
    font.draw(game.score.right_score, ((width / 3) * 2) - 20, 50, 0)
  end

  def draw_rectangular_element(element)
    Gosu.draw_rect(element.position.x, element.position.y, element.width, element.height, FOREGROUND_COLOR)
  end

  def font
    @_font ||= Gosu::Font.new(self, "Arial", 70)
  end
end
