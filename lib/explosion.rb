# Explosion
class Explosion
  attr_reader :start_anim

  def initialize(anim, bullet, clock)
    @anim = anim
    @bullet = bullet
    @start_anim = clock
    @x = @bullet.x
    @y = @bullet.y
  end

  def draw
    animation = @anim[Gosu.milliseconds / 100 % @anim.size]
    animation.draw(@x, @y, 0)
  end
end
