require "sinatra"
require "erb"
require_relative "classes/game.rb"
require_relative "classes/human.rb"
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
		session[:just_played] = false
		session[:player1] = Player.new(session[:player1_name], player1_type, player1_piece)
		session[:player2] = Player.new(session[:player2_name], player2_type, player2_piece)
		session[:game] = Game.new(session[:first_move], session[:player1], session[:player2])
		session[:board] = Board.new(session[:size])
		redirect "/play_game"
	end
end


post "/computerVScomputer_play" do
	player1_type = set_player_type(params[:difficulty_selection1].downcase, "X")
	player2_type = set_player_type(params[:difficulty_selection2].downcase, "O")
	session[:player1] = Player.new("Computer 1", player1_type, "X")
	session[:player2] = Player.new("Computer 2", player2_type, "O")
	session[:game] = Game.new(session[:first_move],session[:player1], session[:player2])
	session[:board] = Board.new(session[:size])
	session[:compVScomp] = true
	redirect "/play_game"
end


get "/play_game" do
	redirect "/game_over" if session[:board].game_over
	session[:current_move] = session[:game].current_player.choose_move(session[:game], session[:board])
	if session[:current_move] == "human_move"	
		erb :board
	else
		session[:board].change_state(session[:current_move].to_i, session[:game].current_player.piece)
		redirect "/game_over" if session[:board].game_over
		session[:game].change_turn
		erb :board
	end
end


get "/human_move" do
	if session[:board].check_position(params[:current_move].to_i) == false
		erb :board
	else
		session[:current_move] = params[:current_move]
		session[:board].change_state(session[:current_move].to_i, session[:game].current_player.piece)
		redirect "/game_over" if session[:board].game_over
		session[:game].change_turn
		redirect "/play_game"
	end
end


get "/game_over" do
	if session[:board].check_winner
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
	session[:board] = Board.new(session[:size])
	session[:game].current_player = params[:first_move] == "player1" ? session[:player1] : session[:player2]
	redirect "/play_game"
end


