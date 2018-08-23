require "sinatra"
require "erb"
require_relative "game.rb"
require_relative "human.rb"
require_relative "computer.rb"
require_relative "board.rb"
require_relative "random.rb"
require_relative "sequential.rb"
require_relative "unbeatable.rb"
require_relative "player.rb"

use Rack::Session::Pool

get "/" do
	session.clear
	erb :setup
end


post "/welcome" do
	if params[:game_type] == "computer"
		erb :difficulty
	else
		erb :welcome
	end
end

post '/info' do
	session[:player1_name] = params[:player1]
	session[:player2_name] = params[:player2]
	session[:difficulty] = params[:difficulty]
	puts "DIFFICULTY" *(500)
	p session[:difficulty]
	if session[:player2_name] == nil
	   session[:player2_name] = "Computer"
	end
	redirect "/new_game"
end

get "/new_game" do
	erb :new_game
end

post "/start_game" do
	session[:first_move] = params[:first_move]
	if session[:player2_name] == "Computer"
		player2_type = session[:difficulty].downcase
	end

	player1_piece = "X"
	player2_piece = "O"

	if session[:player1_name] == "Computer1"
		erb :difficulty
	else
		session[:game] = Game.new(session[:player1_name], session[:player2_name], "human", player2_type, player1_piece, player2_piece, session[:first_move], 4)
		puts "GAME" *(100)
		session[:just_played] = false
		redirect "/play_game"
		# initialize(player1_name, player2_name, player1_type, player2_type, player1_piece, player2_piece, goes_first, size)
		# redirect "/move?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&first_move=" + first_move
	end
end

get "/play_game" do
	puts "PARAMS" *(100)
	p params
	session[:just_played] = params.dig(:just_played)
	if session[:just_played] == "human"
		puts "HUMAN" *(500)
		session[:game].board.change_state(params[:current_move].to_i, session[:game].current_player.piece)
		redirect "/game_over" if session[:game].game_over
		session[:game].change_turn
		puts "CURRENT PLAYER IS NOW #{session[:game].current_player.name}"
	end 


	if session[:game].current_player.type.class == Human 
		erb :board 
	else
		puts "COMPUTER MOVE" *(100)
		p session[:difficulty]
		p session[:game].current_player.type

		session[:current_move] = session[:game].current_player.choose_move
		session[:game].board.change_state(session[:current_move].to_i, session[:game].current_player.piece)
		redirect "/game_over" if session[:game].game_over
		session[:game].change_turn
		session[:just_played] = "computer"
		redirect "/play_game"
	end
end

# post '/computer_play' do
# 	# session[:number_of_players] = params[:number_of_players]
# 	player1_name = "Computer1"
# 	player2_name = "Computer2"
# 	computer1_level = params[:difficulty_selection1]
# 	computer2_level = params[:difficulty_selection2]
# 	redirect "/new_computer_game?player1_name=" + player1_name + "&player2_name=" + player2_name + "&computer1_level=" + computer1_level + "&computer2_level=" + computer2_level
# end

# get "/new_computer_game" do
# 	player1_name = params[:player1_name]
# 	player2_name = params[:player2_name]
# 	computer1_level = params[:computer1_level]
# 	computer2_level = params[:computer2_level]
# 	difficulty = "placeholder"
# 	first_move = "placeholder"
# 	session[:game] = Game.new(player1_name, player2_name, difficulty, first_move, computer1_level, computer2_level)

# 	redirect "/move?player1_name=" + player1_name + "&player2_name=" + player2_name + "&computer1_level=" + computer1_level + "&computer2_level=" + computer2_level + "&difficulty=" + difficulty
# end


# get '/move' do
# 	player1_name = params[:player1_name]
# 	player2_name = params[:player2_name]
# 	difficulty = params[:difficulty]
# 	# session[:current_move] = params[:move]
# 	if session[:game].current_player.name == "Computer1" || session[:game].current_player.name == "Computer2"
# 		loop do
# 			level = [Random.new, Sequential.new, Unbeatable.new][session[:game].current_player.level.to_i - 1]
# 			# current_move = session[:game].current_player.move(session[:game].board_state, session[:game].overall_status)
# 			current_move = level.move(session[:game].board_state, session[:game].overall_status, session[:game].current_player.piece, session[:game].current_player.opponent_piece)

# 			game_status = session[:game].update_game_status(current_move)

# 			case game_status
# 			when "winner"
# 				redirect "/winner?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 			when "tie"
# 				redirect "/winner?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 			when "no_dice"
# 				redirect "/no_dice?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 			else
# 			end
# 		end

# 	elsif session[:game].current_player.class == Computer
# 		level = [Random.new, Sequential.new, Unbeatable.new][difficulty.to_i - 1]
# 		# current_move = session[:game].current_player.move(session[:game].board_state, session[:game].overall_status)
# 		current_move = level.move(session[:game].board_state, session[:game].overall_status, session[:game].current_player.piece, session[:game].current_player.opponent_piece)
# 		redirect "/update_game_status?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&current_move=" + current_move.to_s

# 	else
# 		redirect "/board?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty
# 	end

# end


# get '/update_game_status' do
# 	player1_name = params[:player1_name]
# 	player2_name = params[:player2_name]
# 	difficulty = params[:difficulty]
# 	current_move = params[:current_move]
# 	# first_move = params[:first_move]
# 	if session[:game].current_player.class == Computer
# 		game_status = session[:game].update_game_status(current_move.to_i)
# 	else
# 		game_status = session[:game].update_game_status(params[:current_move].to_i)
# 	end

# 	case game_status
# 	when "winner"
# 		redirect "/winner?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty  + "&game_status=" + game_status
# 	when "tie"
# 		redirect "/winner?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 	when "no_dice"
# 		redirect "/no_dice?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 	else
# 		redirect "/move?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&game_status=" + game_status
# 	end

# en


get "/game_over" do
	if session[:game].board.check_winner
		session[:message1] = "Way to go #{session[:game].current_player.name}, YOU WIN!!"
		session[:game].current_player.increase_score
	else
		session[:message1] = "Better luck next time...IT'S A TIE!"
	end
	erb :winner
end


get "/again" do
	player1_name = params[:player1_name]
	player2_name = params[:player2_name]
	erb :again, locals: {player1_name: player1_name, player2_name: player2_name}
end


post "/again" do
		first_move = params[:first_move]
		player1_name = params[:player1_name]
		player2_name = params[:player2_name]
		if player2_name == "Computer2" 
			difficulty = session[:game].player2.level.to_s
		elsif player2_name == "Computer"
				difficulty = session[:game].player2.level.to_s
		else
			difficulty = "placeholder"
		end
			session[:game].play_again(first_move)
			redirect "/move?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&first_move=" + first_move		# else
end

get "/board" do
	player1_name = params[:player1_name]
	player2_name = params[:player2_name]
	difficulty = params[:difficulty]

	erb :board, locals: {player1_name: player1_name, player2_name: player2_name, difficulty: difficulty}
end
