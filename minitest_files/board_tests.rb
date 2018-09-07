require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_boolean
		assert_equal(true, true)
	end

	def test_combos
		size = 3
		board = Board.new(size)
		combos = board.combos
		assert_equal([[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]], combos)
	end

	def test_combos_4_in_a_row
		size = 4
		board = Board.new(size)
		combos = board.combos
		assert_equal(10, combos.length)
	end

	def test_overall_status
		size = 3
		board = Board.new(size)
		status = board.overall_status
		assert_equal([[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]], status)
	end

	def test_check_available_spaces
		board = Board.new(3)
		board.state = ["X","O","X",4,"X","O","O",8,"X"]
		spaces = board.check_available_spaces
		assert_equal([4,8], spaces)
	end

	def test_check_available_spaces_5X5
		board = Board.new(5)
		board.state = ["X","O","X",3,"X","O","O",7,"X",8,9,10,11,12,"X","X","X","O","O",18,19,20,21,22,23,24]
		spaces = board.check_available_spaces
		assert_equal([3,7,8,9,10,11,12,18,19,20,21,22,23,24], spaces)
	end

	def test_new_game_board_state
		board = Board.new(3)	
		function = board.state
		assert_equal([0,1,2,3,4,5,6,7,8], function)
	end

	def test_check_winner_1
		board = Board.new(3)
		board.state = ["X","O","X",4,"X","O","O",8,"X"]
		function = board.check_winner
		assert_equal(true, function)
	end

	def test_check_winner_2
		board = Board.new(3)
		board.state = ["X",2,"O","O","O",6,"X","X","X"]
		function = board.check_winner
		assert_equal(true, function)
	end

	def test_check_winner_5X5
		board = Board.new(5)
		board.state = ["X","X","X","X","X","O","O",7,"X",8,9,10,11,12,"X","X","X","O","O",18,19,20,21,22,23,24]
		function = board.check_winner
		assert_equal(true, function)
	end	

	def test_check_board_position_1
		board = Board.new(3)
		board.state = ["X","O","X",3,"X","O","O",7,"X"]
		function = board.check_position(3)
		assert_equal(true, function)
	end

	def test_check_board_position_2
		board = Board.new(3)
		board.state = ["X","O","X",3,"X","O","O",7,"X"]
		function = board.check_position(5)
		assert_equal(false, function)
	end

	def test_check_tie
		board = Board.new(3)
		board.state = ["X","O","X","O","X","O","X","O","X"]
		function = board.check_tie
		assert_equal(true, function)
	end

	def test_check_tie_2
		board = Board.new(3)
		board.state = [0,"O","X","O","X","O","X","O","X"]
		function = board.check_tie
		assert_equal(false, function)
	end

	def test_game_won_by
		board = Board.new(3)
		board.state = ["X","X","X","O","O",6,"X","O","X"]
		function = board.game_won_by("X")
		assert_equal(true, function)
	end

end