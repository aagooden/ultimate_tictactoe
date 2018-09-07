require "minitest/autorun"
require "./classes/game.rb"
require "./classes/human.rb"
require "./classes/board.rb"
require "./classes/random.rb"
require "./classes/sequential.rb"
require "./classes/unbeatable.rb"
require "./classes/player.rb"

class Tictactoe_test < Minitest::Test

	def test_computer_VS_computer_unbeatable

		tie_count = 0
		win_count = 0
		for x in (1..100) do
			board = Board.new(3)
			type1 = Unbeatable.new('X')
			type2 = Unbeatable.new('O')
			player1 = Player.new("Aaron", type1, "X")
			player2 = Player.new("Fred", type2, "O")
			game = Game.new("player1", player1, player2)

			loop do
				current_move = game.current_player.choose_move(game,board)

				board.change_state(current_move, game.current_player.piece)

				if board.game_won_by("X")
					win_count += 1
					break
				end

				if board.game_won_by("O")
					win_count += 1
					break
				end

				if board.check_tie
					tie_count += 1
					break
				end
				game.change_turn
			end
		end
		assert_equal(100, tie_count)
	end


	def test_computer_VS_computer_unbeatableVSrandom
		tie_count = 0
		win_count = 0
		for x in (1..100) do
			board = Board.new(3)
			type1 = Unbeatable.new('X')
			type2 = Random.new
			player1 = Player.new("Aaron", type1, "X")
			player2 = Player.new("Fred", type2, "O")
			game = Game.new("player1", player1, player2)

			loop do
				current_move = game.current_player.choose_move(game,board)

				board.change_state(current_move, game.current_player.piece)

				if board.game_won_by("X")
					win_count += 1
					break
				end

				if board.game_won_by("O")
					break
				end

				if board.check_tie
					tie_count += 1
					break
				end
				game.change_turn
			end
		end
		assert_equal(100, tie_count+win_count)
	end

end

