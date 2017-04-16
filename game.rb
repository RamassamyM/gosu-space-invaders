require 'gosu'
require_relative 'lib/player'
require_relative 'lib/enemy'
require_relative 'lib/explosion'

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
    @explosions = []
    @clock = 0
    @font = Gosu::Font.new(20)
    load_sounds
  end

  def load_sounds
    @enemy_passed_sound = Gosu::Sample.new('media/NFF-whizz.wav')
    @enemy_hit_sound = Gosu::Sample.new('media/NFF-feed-2.wav')
    @player_hit_sound = Gosu::Sample.new('media/NFF-springy-hit.wav')
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
          run_explosion_anim(enemy)
          @enemy_hit_sound.play(0.5)
          @enemies.delete(enemy)
          @player.score += 10
        end
      end
    end
  end

  def detect_player_hits
    @enemies.each do |enemy|
      @player_hit_sound.play if Gosu.distance(@player.x, @player.y, enemy.x, enemy.y) < 20
    end
  end

  def run_explosion_anim(enemy)
    @explosions << Explosion.new(enemy, @clock)
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
      if enemy.y >= HEIGHT
        @enemies.delete(enemy)
        @enemy_passed_sound.play
      end
      enemy.move
    end
  end

  def explosions_update
    @explosions.each do |explosion|
      anim_time = @clock - explosion.start_anim
      @explosions.delete(explosion) if anim_time >= 20
    end
  end

  def update
    @clock += 1
    player_update
    enemies_update
    detect_hits
    explosions_update
  end

  def draw
    @background.draw(0, 0, 0)
    @player.draw
    @player.bullets.each(&:draw)
    @enemies.each(&:draw)
    @explosions.each(&:draw)
    show_score
  end
end

Game.new.show
