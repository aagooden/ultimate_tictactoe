class Unbeatable

  attr_reader :piece, :opponent_piece

  def initialize(piece)
    @piece = piece
    @piece == "X" ? @opponent_piece = "O" : @opponent_piece = "X"
  end

  def choose_move(game)
    @best_score = {}
    negamax(game)
    # same_values = []
    # max_int = @best_score.max_by {|key, value| value}[0]
    # @best_score.each {|key, value| same_values.push(key) if value == max_int}
    # move = same_values.sample
    puts "best score in choose_move is #{@best_score}"
    move = @best_score.max_by {|key, value| value}[0]
    puts "MOVE IS #{move}"
    return move
  end

  private

  def negamax(game, depth = 0, player_value = 1)
    counter = 0
    # puts "SCORE SCENARIOS TEST"
    return player_value * score_scenarios(game, depth) if game.game_over #|| depth>5

    max = -1000

    game.board.check_available_spaces.each do |position|
      puts "First position is #{position}"
      # puts "Available spaces array is #{game.board.check_available_spaces}"
      # puts "POSITION IS #{position}"
      game.board.change_state(position, game.current_player.piece)
      game.change_turn

      negamax_value = -negamax(game, depth+1, -player_value)

      game.board.change_state(position, position)
      puts "Second position is #{position}"
      # counter += 1
      # puts "THE COUNTER IS NOW #{counter}"
      # puts "Available spaces array is NOW #{game.board.check_available_spaces}"
      # puts "BOOM!!!"
      game.change_turn

      # puts "NEGAMAX-VALUE is #{negamax_value}"
      max = [max, negamax_value].max
      # puts "BLAMMOO" if depth == 0
      @best_score[position] = max if depth == 0

      # alpha = [alpha, negamax_value].max
      # puts "ALPHA IS #{alpha}"
      # puts "BETA IS #{beta}"
      # return alpha if alpha >= beta
    end
    # puts "MAX IS #{max}" 

    return max
  end



  # def negamax(game, depth = 0, alpha = -1000, beta = 1000, player_value = 1)
  #   puts "SCORE SCENARIOS TEST"
  #   p score_scenarios(game,depth) if game.game_over
  #   return player_value * score_scenarios(game, depth) if game.game_over || depth>5

  #   max = -1000

  #   game.board.check_available_spaces.each do |position|
  #     puts "POSITION IS #{position}"
  #     game.board.change_state(position, game.current_player.piece)
  #     game.change_turn

  #     negamax_value = -negamax(game, depth+1, -beta, -alpha, -player_value)

  #     game.board.change_state(position, position)
  #     game.change_turn

  #     puts "NEGAMAX-VALUE is #{negamax_value}"
  #     max = [max, negamax_value].max
  #     @best_score[position] = max if depth == 0

  #     alpha = [alpha, negamax_value].max
  #     puts "ALPHA IS #{alpha}"
  #     puts "BETA IS #{beta}"
  #     return alpha if alpha >= beta
  #   end
  #   puts "MAX IS #{max}" 
  #   return max
  # end


  def score_scenarios(game, depth)
    if game.game_won_by(self.piece)
      # puts "It is #{1000/depth} because the computer #{self.piece} won on this branch"
      return 1000 / depth
    elsif game.game_won_by(self.opponent_piece) 
    # puts "It is #{-1000/depth} because the computer's opponent #{self.opponent_piece} won on this branch"
      return -1000 / depth
    else
      # puts "It is 0 because it is a tie on this branch"
      return 0 
    end
  end


end


