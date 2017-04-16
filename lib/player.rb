require_relative 'sprite'
require_relative 'bullet'

# class Player
class Player < Sprite
  attr_reader :bullets
  attr_accessor :score
  def initialize(img, game_width)
    super(img)
    @game_width = game_width
    @x, @y = 0
    @score = 0
    @speed = 4
    @bullets = []
  end

  def wrap(x, y)
    @x = x
    @y = y
  end

  def move_left
    @x -= @speed unless @x <= 0
  end

  def move_right
    @x += @speed unless @x + @width >= @game_width
  end

  def load_fire(img)
    # each bullet has a reference on Player for its starting position (x, y)
    @bullets << Bullet.new(img, self)
  end

  def fire
    @bullets.each do |bullet|
      bullet.move
      @bullets.delete(bullet) if bullet.y <= 0
    end
  end
end
