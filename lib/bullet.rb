require_relative 'sprite'

# class Bullet
class Bullet < Sprite
  def initialize(img, player)
    super(img)
    @player = player
    @x = @player.x + @player.width / 2 - @img.width / 2
    @y = @player.y
    @speed = 8.0
  end

  def move
    @y -= @speed
  end
end
