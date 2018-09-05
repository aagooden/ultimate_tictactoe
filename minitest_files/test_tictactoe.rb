require "minitest/autorun"
require_relative "game.rb"
require_relative "board.rb"
require_relative "random.rb"
require_relative "sequential.rb"
require_relative "unbeatable.rb"
require_relative "player.rb"

class Tictactoe_test < Minitest::Test

	def test_boolean
		assert_equal(true, true)
	end

	def test_block_fork
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X",1,2,3,"O",5,6,7,"O"]
		function = game.current_player.choose_move
		p game.board.state 
		assert_equal(2, function)
	end

	def test_author_example
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","X","O",3,"O","X",6,7,"O"]
		function = game.current_player.choose_move
		assert_equal(6, function)
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
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X",4,"X","O","O",8,"X"]
		spaces = game.board.check_available_spaces
		assert_equal([4,8], spaces)
	end

	def test_win_move_4by4
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 4)
		game.board.state = ["X",1,2,"O",4,"X","O",7,8,9,"X",11,12,13,14,15]
		function = game.current_player.choose_move
		assert_equal(15, function)
	end

		def test_block_move_5by5
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 4)
		game.board.state = ["X","X","X","O",4,5,"O",7,8,"O","O",11,12,13,14,15]
		function = game.current_player.choose_move
		assert_equal(12, function)
	end

	def test_new_game_board_state
	  game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		function = game.board.state
	  assert_equal([0,1,2,3,4,5,6,7,8], function)
	end

	def test_check_winner_1
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X",4,"X","O","O",8,"X"]
		function = game.board.check_winner
		assert_equal(true, function)
	end

	def test_change_turn
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X",4,"X","O","O",8,"X"]
		game.change_turn
		player = game.current_player.name
		assert_equal("Fred", player)
	end

	def test_check_winner_2
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X",2,"O","O","O",6,"X","X","X"]
		function = game.board.check_winner
		assert_equal(true, function)
	end

	def test_game_won_by
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","X","X","O","O",6,"X","O","X"]
		function = game.game_won_by("X")
		assert_equal(true, function)
	end


	def test_check_board_position_1
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X",3,"X","O","O",7,"X"]
		function = game.board.check_position(3)
		assert_equal(true, function)
	end

	def test_check_board_position_1
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X",3,"X","O","O",7,"X"]
		function = game.board.check_position(5)
		assert_equal(false, function)
	end

	def test_check_tie
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","O","X","O","X","O","X","O","X"]
		function = game.board.check_tie
		assert_equal(true, function)
	end

	def test_check_tie_2
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = [0,"O","X","O","X","O","X","O","X"]
		function = game.board.check_tie
		assert_equal(false, function)
	end

	def test_winning_move_with_possible_block_present
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X","X","O","O","O",5,"X",7,"X"]
		function = function = game.current_player.choose_move
		assert_equal(7, function)
	end

	def test_fork_block_2_with_only_one_fork_possibility
		game = Game.new("Aaron", "Fred", "unbeatable", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["X",1,2,3,"O","X",6,7,8]
		function = function = game.current_player.choose_move
		assert_equal(2, function)
	end

	def test_sequential_level
		game = Game.new("Aaron", "Fred", "sequential", "unbeatable", "X", "O", "player1", 3)
		game.board.state =  ["O","O","X",3,"X",5,6,"X",8]
		function = function = game.current_player.choose_move
		assert_equal(3, function)
	end

	def test_sequential_level_2
		game = Game.new("Aaron", "Fred", "sequential", "unbeatable", "X", "O", "player1", 3)
		game.board.state =  ["O","O","X","O","X",5,6,"X",8]
		function = game.current_player.choose_move
		assert_equal(5, function)
	end

	def test_random_level_1
		game = Game.new("Aaron", "Fred", "random", "unbeatable", "X", "O", "player1", 3)
		game.board.state = ["O","O","X","O","X","X",6,"X",8]
		possible = [6,8]
		actual = game.current_player.choose_move
		contain = possible.include?(actual)
		assert_equal(true, contain)
	end

	def test_random_level_2
		game = Game.new("Aaron", "Fred", "random", "unbeatable", "X", "O", "player1", 3)
		game.board.state = [0,1,"X","X","O",5,"O",7,8]
		possible = [0,1,5,7,8]
		actual = game.current_player.choose_move
		contain = possible.include?(actual)
		assert_equal(true, contain)
	end

	# def test_computer_VS_computer_unbeatable
	# 	tie_count = 0
	# 	win_count = 0
	# 	for x in (1..1000) do
	# 		game = Game.new("Computer1", "Computer2", "unbeatable","random", "X", "O", "player1", 3)

	# 		loop do
	# 			current_move = game.current_player.choose_move

	# 			game.board.change_state(current_move, game.current_player.piece)


	# 			if game.game_won_by("X")
	# 				win_count += 1
	# 				break
	# 			end

	# 			if game.board.check_tie
	# 				tie_count += 1
	# 				break
	# 			end

	# 		end

	# 	end
	# 	puts "The results of the unbeatable VS unbeatable test are:"
	# 	puts "The number of ties were #{tie_count}"
	# 	puts "The number of wins were #{win_count}"
	# end

	# 	def test_computer_VS_computer_random
	# 	tie_count = 0
	# 	player1_count = 0
	# 	player2_count = 0
	# 	for x in (1..1000) do
	# 		game = Game.new("Computer1", "Computer2", "random", "random", "X", "O", "player1", 3)

	# 		loop do
	# 			current_move = game.current_player.choose_move

	# 			game.board.change_state(current_move, game.current_player.piece)


	# 			if game.game_won_by("X")
	# 				player1_count += 1
	# 				break
	# 			end

	# 			if game.game_won_by("O")
	# 				player2_count += 1
	# 				break
	# 			end

	# 			if game.board.check_tie
	# 				tie_count += 1
	# 				break
	# 			end
	# 						game.change_turn
	# 		end

	# 	end

	# 	puts "The number of ties were #{tie_count}"
	# 	puts "The number of wins by Computer1 were #{player1_count}"
	# 	puts "The number of wins by Computer2 were #{player2_count}"
	# end

	
end
