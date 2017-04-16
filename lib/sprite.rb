# class Sprite : parent class for all drawable
# objects, except animations
# - img drawing
# - bounding box collision management
class Sprite
  attr_reader :x, :y, :width, :height

  def initialize(img)
    @img = img
    @width = @img.width
    @height = @img.height
  end

  def wrap(x, y)
    @x = x
    @y = y
  end

  def draw
    @img.draw(@x, @y, 0)
  end

  # Bouding box collision detect -----------------------------------------------
  def right?(sprite)
    sprite.x >= @x + @width
  end

  def left?(sprite)
    sprite.x + sprite.width <= @x
  end

  def down?(sprite)
    sprite.y >= @y + @height
  end

  def up?(sprite)
    sprite.y + sprite.height <= @y
  end

  def collide?(sprite)
    right = right?(sprite)
    left = left?(sprite)
    down = down?(sprite)
    up = up?(sprite)
    if right || left || down || up
      false
    else
      true
    end
  end
end
