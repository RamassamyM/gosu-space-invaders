require_relative 'bullet'

# class Player
class Player
  attr_reader :x, :y, :img, :width, :height, :bullets
  attr_accessor :score
  def initialize(game_width)
    @game_width = game_width
    @img_path = File.dirname(__FILE__) + '/../media/player.png'
    @img = Gosu::Image.new(@img_path)
    @width = @img.width
    @height = @img.height
    @x, @y, @score = 0
    @speed = 4
    @bullets = []
  end

  def wrap(x, y)
    @x = x
    @y = y
  end

  def draw
    @img.draw(@x, @y, 0)
  end

  def move_left
    @x -= @speed unless @x <= 0
  end

  def move_right
    @x += @speed unless @x + @width >= @game_width
  end

  def load_fire
    # each bullet has a reference on Player for its starting position (x, y)
    @bullets << Bullet.new(self)
  end

  def fire
    @bullets.each do |bullet|
      bullet.move
      @bullets.delete(bullet) if bullet.y <= 0
    end
  end
end
