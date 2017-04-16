Ruby, Gosu and fun
------------------

This repo contains a (very) minimal example of a 2d game built with
[Gosu](https://www.libgosu.org/ruby.html).
It comes from my own experiment with Gosu at
[Le Wagon Bordeaux](https://www.lewagon.com/fr/bordeaux) 9 weeks bootcamp.
Thank you guys :)

Feel free to clone it and of course improve it ; so far it lacks of :

- [x] animations for hits *DONE*
- [] a start screen
- [] sounds
- [] game-over
- [] and it's obviously a very bad game

# Basics

## Installation

```bash
$ gem install gosu
```

## Structure
```
.
game.rb
├── lib/
│   ├── bullet.rb
│   ├── enemy.rb
│   └── player.rb
└── media/
    ├── background.jpg
    ├── enemy.png
    ├── bullet.png
    └── player.png
```

`lib/player.rb`, `lib/enemy.rb` and `lib/bullet.rb` are classes for your sprites ; window management, display and logics are managed in `game.rb`. Put your assets in `media/`

## Run game

```bash
$ ruby game.rb
```

Move player with left and right arrows.

## `game.rb` file

The minimal structure for main script is  :

```ruby
require 'gosu'
require_relative 'player'
# ...
# and any other class instantiated here

class Game < Gosu::Window
  def initialize
    super(640, 480)
    # of course you can also play full screen
    # instantiate here your player and enemies
    # ...
  end

  # Here come two mandatory methods, update and draw, each
  # called at 60 fps :
  def update
    # capture events and manage game logic
    # ...
  end

  def draw
    # draw window background, sprites, etc.
    # ...
  end
end

Game.new.show
# that's all folks !
```

# Further

See [Gosu's github tutorial](https://github.com/gosu/gosu/wiki/Ruby-Tutorial) for a full example.
[Documentation](http://www.rubydoc.info/github/gosu/gosu)
