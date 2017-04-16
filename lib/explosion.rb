# Explosion
class Explosion
  attr_reader :start_anim

  def initialize(bullet, clock)
    @bullet = bullet
    @start_anim = clock
    @x = @bullet.x
    @y = @bullet.y
    # (210 x 30) / 7 => (30 x 30)
    @img_path = File.dirname(__FILE__) + '/../media/explosion.png'
    @animation = Gosu::Image.load_tiles(@img_path, 30, 30)
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    # img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0)
    img.draw(@x, @y, 0)
  end
end
