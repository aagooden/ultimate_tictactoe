require "sinatra"
require "erb"
require_relative "classes/game.rb"
require_relative "classes/human.rb"
require_relative "classes/computer.rb"
require_relative "classes/board.rb"
require_relative "classes/random.rb"
require_relative "classes/sequential.rb"
require_relative "classes/unbeatable.rb"
require_relative "classes/player.rb"

use Rack::Session::Pool

def set_player_type(type, piece)
	case type
        when "random"
            type = Random.new
        when "sequential"
            type = Sequential.new
        when "human"
            type = Human.new
        when "unbeatable"
            type = Unbeatable.new(piece)
        end
    return type
end

get "/" do
	session.clear
	erb :setup
end


post "/welcome" do
	session[:size] = params[:size].to_i
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
	if session[:player2_name] == nil
	   session[:player2_name] = "Computer"
	end
	redirect "/new_game"
end


get "/new_game" do
	erb :new_game
end


post "/start_game" do

	player1_piece = "X"
	player2_piece = "O"	

	session[:first_move] = params[:first_move]
	if session[:player2_name] == "Computer"
		player2_type = set_player_type(session[:difficulty].downcase, player2_piece)
	else
		player2_type = set_player_type("human", player2_piece)
	end

	if session[:player1_name] == "Computer1"
		erb :difficulty
	else
		player1_type = Human.new()
		
		# session[:game] = Game.new(session[:player1_name], session[:player2_name], "human", player2_type, player1_piece, player2_piece, session[:first_move], session[:size])
		session[:just_played] = false
		session[:player1] = Player.new(session[:player1_name], player1_type, player1_piece)
		session[:player2] = Player.new(session[:player2_name], player2_type, player2_piece)
		puts "PLAYER 2 IS ...  " *(50)
		p session[:player2]
		session[:game] = Game.new(session[:first_move], session[:player1], session[:player2])
		session[:board] = Board.new(session[:size])
		redirect "/play_game"
		# initialize(player1_name, player2_name, player1_type, player2_type, player1_piece, player2_piece, goes_first, size)
		# redirect "/move?player1_name=" + player1_name + "&player2_name=" + player2_name + "&difficulty=" + difficulty + "&first_move=" + first_move
	end
end

post "/computerVScomputer_play" do
	session[:game] = Game.new("Computer 1", "Computer 2", params[:difficulty_selection1].downcase, params[:difficulty_selection2].downcase, "X", "O", session[:first_move], session[:size])
	session[:just_played] = true
	session[:compVScomp] = true
	redirect "/play_game"
end

get "/play_game" do
	# session[:just_played] = params.dig(:just_played)

			session[:current_move] = session[:game].current_player.choose_move(session[:game], session[:board])
			if session[:current_move] == "human_move"
				session[:game].change_turn
				erb :board
			else
			session[:board].change_state(session[:current_move].to_i, session[:game].current_player.piece)
			redirect "/game_over" if session[:board].game_over
			session[:game].change_turn
			# session[:just_played] = "computer"
			# redirect "/play_game"
			erb :board
			end
end





# get "/play_game" do
# 	session[:just_played] = params.dig(:just_played)

# 	if session[:compVScomp] == true && session[:just_played] == "human"
# 		erb :board
# 	else

# 		if session[:game].board.check_position(params[:current_move].to_i) == false
# 			erb :board

# 		elsif session[:just_played] == "human"
# 			session[:game].board.change_state(params[:current_move].to_i, session[:game].current_player.piece)
# 			redirect "/game_over" if session[:game].game_over
# 			session[:game].change_turn
# 		end 


# 		if session[:game].current_player.type.class == Human 
# 			erb :board 
# 		else
# 			session[:current_move] = session[:game].current_player.choose_move(session[:game], session[:board])
# 			session[:board].change_state(session[:current_move].to_i, session[:game].current_player.piece)
# 			redirect "/game_over" if session[:game].game_over
# 			session[:game].change_turn
# 			session[:just_played] = "computer"
# 			# redirect "/play_game"
# 			erb :board
# 		end
# 	end
# end


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
	erb :again
end


post "/again" do
	session[:game].play_again(params[:first_move])
	session[:just_played] = false
	redirect "/play_game"
end
