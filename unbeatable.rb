class Unbeatable

  attr_reader :piece, :opponent_piece

  def initialize(piece)
    @piece = piece
    @piece == "X" ? @opponent_piece = "O" : @opponent_piece = "X"
  end

  def choose_move(game)
    @best_score = {}
    negamax(game)
    puts "best score in choose_move is #{@best_score}"
    move = @best_score.max_by {|key, value| value}[0]
    return move
  end

  private

  def negamax(game, depth = 0, alpha = -1000, beta = 1000, color = 1)
 
    return color * score_scenarios(game, depth) if game.game_over || depth>5

    max = -1000

    game.board.check_available_spaces.each do |position|
      game.board.change_state(position, game.current_player.piece)
      game.change_turn
      negamax_value = -negamax(game, depth+1, -beta, -alpha, -color)

      game.board.change_state(position, position)
      game.change_turn

      max = [max, negamax_value].max
      @best_score[position] = max if depth == 0

      alpha = [alpha, negamax_value].max
      puts "ALPHA is #{alpha}" if alpha >= beta
      return alpha if alpha >= beta
    end
    max
  end

  def score_scenarios(game, depth)
    p self
    if game.game_won_by(self.piece)
      return 1000 / depth
    elsif game.game_won_by(self.opponent_piece)     
      return -1000 / depth
    else
      return 0 
    end
  end

end


