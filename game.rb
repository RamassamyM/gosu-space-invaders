require 'gosu'
require_relative 'lib/player'
require_relative 'lib/enemy'

# class Game
class Game < Gosu::Window
  WIDTH = 640
  HEIGHT = 480
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Gosu demo'
    @background = Gosu::Image.new('media/background.jpg')
    @player = Player.new(WIDTH)
    @player.wrap(WIDTH / 2 + @player.width / 2, HEIGHT - @player.height - 10)
    @enemies = []
    @clock = 0
    @font = Gosu::Font.new(20)
  end

  def show_score
    @font.draw(
      "Score: #{@player.score}",
      10, 10, 0, 1.0, 1.0, Gosu::Color::AQUA
    )
  end

  def enemies_wave(enemies_nb)
    enemies_nb.times { @enemies << Enemy.new }
  end

  def detect_hits
    @enemies.each do |enemy|
      @player.bullets.each do |bullet|
        if Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) < 20
          @enemies.delete(enemy)
          @player.score += 10
        end
      end
    end
  end

  def player_update
    @player.move_left if Gosu.button_down?(Gosu::KB_LEFT)
    @player.move_right if Gosu.button_down?(Gosu::KB_RIGHT)
    @player.load_fire if (@clock % 7).zero?
    @player.fire
  end

  def enemies_update
    enemies_wave(rand(5..10)) if (@clock % 125).zero?
    @enemies.each do |enemy|
      @enemies.delete(enemy) if enemy.y >= HEIGHT
      enemy.move
    end
  end

  def update
    @clock += 1
    player_update
    enemies_update
    detect_hits
  end

  def draw
    @background.draw(0, 0, 0)
    @player.draw
    @player.bullets.each(&:draw)
    @enemies.each(&:draw)
    show_score
  end
end

Game.new.show
