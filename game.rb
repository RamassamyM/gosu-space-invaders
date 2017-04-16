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
    load_sounds
    load_images
    self.caption = 'Gosu demo'
    @player = Player.new(@player_img, WIDTH)
    @player.wrap(WIDTH / 2 + @player.width / 2, HEIGHT - @player.height - 10)
    @enemies = []
    @explosions = []
    @clock = 0
    @font = Gosu::Font.new(20)
  end

  # Initialisation -------------------------------------------------------------
  def load_sounds
    @enemy_passed_sound = Gosu::Sample.new('media/sound/NFF-whizz.wav')
    @enemy_hit_sound    = Gosu::Sample.new('media/sound/NFF-feed-2.wav')
    @player_hit_sound   = Gosu::Sample.new('media/sound/NFF-springy-hit.wav')
  end

  def load_images
    @background     = Gosu::Image.new('media/img/background.jpg')
    @player_img     = Gosu::Image.new('media/img/player.png')
    @bullet_img     = Gosu::Image.new('media/img/bullet.png')
    @enemy_img      = Gosu::Image.new('media/img/enemy.png')
    @explosion_anim = Gosu::Image.load_tiles('media/img/explosion.png', 30, 30)
  end

  # Logic and update -----------------------------------------------------------
  def enemies_wave(enemies_nb)
    enemies_nb.times { @enemies << Enemy.new(@enemy_img) }
  end

  def detect_hits
    @enemies.each do |enemy|
      @player.bullets.each do |bullet|
        next unless bullet.collide?(enemy)
        run_explosion_anim(enemy)
        @enemy_hit_sound.play(0.5)
        @enemies.delete(enemy)
        @player.score += 10
      end
    end
  end

  def detect_player_hits
    @enemies.each do |enemy|
      @player_hit_sound.play if @player.collide?(enemy)
    end
  end

  def player_update
    @player.move_left if Gosu.button_down?(Gosu::KB_LEFT)
    @player.move_right if Gosu.button_down?(Gosu::KB_RIGHT)
    @player.load_fire(@bullet_img) if (@clock % 7).zero?
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

  # Display --------------------------------------------------------------------
  def show_score
    @font.draw(
      "Score: #{@player.score}",
      10, 10, 0, 1.0, 1.0, Gosu::Color::AQUA
    )
  end

  def run_explosion_anim(enemy)
    @explosions << Explosion.new(@explosion_anim, enemy, @clock)
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

# ------------------------------------------------------------------------------
Game.new.show
