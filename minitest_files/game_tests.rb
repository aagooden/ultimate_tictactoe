require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_change_turn
		board = Board.new(3)
		type1 = Random.new
		type2 = Random.new
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X","O","X",4,"X","O","O",8,"X"]
		game.change_turn
		player = game.current_player.name
		assert_equal("Fred", player)
	end

end


		