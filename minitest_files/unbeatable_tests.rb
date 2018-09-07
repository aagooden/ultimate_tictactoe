require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_block_fork
		board = Board.new(3)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X",1,2,3,"O",5,6,7,"O"]
		function = game.current_player.choose_move(game,board)
		assert_equal(2, function)
	end

	def test_author_example
		board = Board.new(3)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X","X","O",3,"O","X",6,7,"O"]
		function = game.current_player.choose_move(game, board)
		assert_equal(6, function)
	end

	def test_win_move_4by4
		board = Board.new(4)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X",1,2,"O",4,"X","O",7,8,9,"X",11,12,13,14,15]
		function = game.current_player.choose_move(game,board)
		assert_equal(15, function)
	end

	def test_block_move_4by4
		board = Board.new(4)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X","X","X","O",4,5,"O",7,8,"O","O",11,12,13,14,15]
		function = game.current_player.choose_move(game,board)
		assert_equal(12, function)
	end

	def test_winning_move_with_possible_block_present
		board = Board.new(3)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X","X","O","O","O",5,"X",7,"X"]
		function = function = game.current_player.choose_move(game,board)
		assert_equal(7, function)
	end

	def test_fork_block_2_with_only_one_fork_possibility
		board = Board.new(3)
		type1 = Unbeatable.new('X')
		type2 = Unbeatable.new('O')
		player1 = Player.new("Aaron", type1, "X")
		player2 = Player.new("Fred", type2, "O")
		game = Game.new("player1", player1, player2)
		board.state = ["X",1,2,3,"O","X",6,7,8]
		function = function = game.current_player.choose_move(game,board)
		assert_equal(2, function)
	end

end