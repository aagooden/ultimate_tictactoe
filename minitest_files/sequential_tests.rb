require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_sequential_level
		board = Board.new(3)
		type1 = Sequential.new
		type2 = Sequential.new
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state =  ["O","O","X",3,"X",5,6,"X",8]
		function = function = game.current_player.choose_move(game,board)
		assert_equal(3, function)
	end

	def test_sequential_level_2
		board = Board.new(3)
		type1 = Sequential.new
		type2 = Sequential.new
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state =  ["O","O","X","O","X",5,6,"X",8]
		function = game.current_player.choose_move(game,board)
		assert_equal(5, function)
	end

end

