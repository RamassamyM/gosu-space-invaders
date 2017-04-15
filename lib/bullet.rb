# class Bullet
class Bullet
  attr_reader :x, :y
  def initialize(player)
    @player = player
    @img_path = File.dirname(__FILE__) + '/../media/bullet.png'
    @img = Gosu::Image.new(@img_path)
    @x = @player.x + @player.width / 2 - @img.width / 2
    @y = @player.y
    @speed = 8.0
  end

  def move
    @y -= @speed
  end

  def draw
    @img.draw(@x, @y, 0)
  end
end
