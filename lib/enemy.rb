# class Enemy
class Enemy
  attr_reader :x, :y, :img
  def initialize
    @img_path = File.dirname(__FILE__) + '/../media/enemy.png'
    @img = Gosu::Image.new(@img_path)
    @x = rand(10..500)
    @y = 0.0
    @speed = rand(1..3).to_f
  end

  def move
    @y += @speed
  end

  def draw
    @img.draw(@x, @y, 0)
  end
end
