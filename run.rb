require 'engine'
require 'player'
require 'console_interface'

Player.new 'Alice', 'X'
Player.new 'Bob'  , 'O'

Engine.instance.interface = ConsoleInterface.new
Engine.instance.start_game