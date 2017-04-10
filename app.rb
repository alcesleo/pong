require "gosu"
require "./lib/paddle"

class Pong < Gosu::Window
  BACKGROUND_COLOR = Gosu::Color::BLACK
  PADDLE_COLOR     = Gosu::Color::WHITE
  PADDLE_MARGIN    = 10
  PADDLE_WIDTH     = 20

  def initialize
    super(640, 480)
    self.caption = "Pong"

    @left_paddle  = Paddle.new(window_height: height)
    @right_paddle = Paddle.new(window_height: height)
  end

  def update
    move_paddle
  end

  def draw
    draw_background
    draw_paddles
  end

  def button_down(key)
    if key == Gosu::KbQ
      close
    end
  end

  def needs_cursor?
    true
  end

  private

  attr_reader :left_paddle, :right_paddle

  def move_paddle
    if button_down?(Gosu::KbUp)
      left_paddle.move_up
    end

    if button_down?(Gosu::KbDown)
      left_paddle.move_down
    end
  end

  def draw_background
    Gosu.draw_rect(0, 0, width, height, BACKGROUND_COLOR)
  end

  def draw_paddles
    draw_left_paddle
    draw_right_paddle
  end

  def draw_left_paddle
    Gosu.draw_rect(PADDLE_MARGIN, left_paddle.position, PADDLE_WIDTH, left_paddle.height, PADDLE_COLOR)
  end

  def draw_right_paddle
    Gosu.draw_rect(width - PADDLE_WIDTH - PADDLE_MARGIN, right_paddle.position, PADDLE_WIDTH, right_paddle.height, PADDLE_COLOR)
  end
end

Pong.new.show
