require_relative 'sprite'

# class Enemy
class Enemy < Sprite
  def initialize(img)
    super(img)
    @x = rand(10..500)
    @y = 0.0
    @speed = rand(1..3).to_f
  end

  def move
    @y += @speed
  end
end
