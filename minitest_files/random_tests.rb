require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_random_level_1
		board = Board.new(3)
		type1 = Random.new
		type2 = Random.new
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["O","O","X","O","X","X",6,"X",8]
		possible = [6,8]
		actual = game.current_player.choose_move(game,board)
		contain = possible.include?(actual)
		assert_equal(true, contain)
	end

	def test_random_level_2
		board = Board.new(3)
		type1 = Random.new
		type2 = Random.new
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = [0,1,"X","X","O",5,"O",7,8]
		possible = [0,1,5,7,8]
		actual = game.current_player.choose_move(game,board)
		contain = possible.include?(actual)
		assert_equal(true, contain)
	end

end