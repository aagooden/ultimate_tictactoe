class Unbeatable

  attr_reader :piece, :opponent_piece

  def initialize(piece)
    @piece = piece
    @piece == "X" ? @opponent_piece = "O" : @opponent_piece = "X"
  end

  def choose_move(game, board)
    @best_score = {}
    negamax(game, board)
    move = @best_score.max_by {|key, value| value}[0]
    return move
  end

  private

  def negamax(game, board, depth = 0, alpha = -1000, beta = 1000, player_value = 1)
    return player_value * base_case_scores(board, depth) if board.game_over || depth>6 #limits depth of negamax to 7 which gains speed

    max = -1000

    board.check_available_spaces.each do |position|

      board.change_state(position, game.current_player.piece)
      game.change_turn
      negamax_value = -negamax(game, depth+1, -beta, -alpha, -player_value)

      max = [max, negamax_value].max

      @best_score[position] = max if depth == 0
      alpha = [alpha, negamax_value].max

      board.change_state(position, position)
      game.change_turn
      return alpha if alpha >= beta
    end 
    return max
  end


  def base_case_scores(board, depth)
    if board.game_won_by(self.piece)
      return 1000 / depth
    elsif board.game_won_by(self.opponent_piece) 
      return -1000 / depth
    else
      return 0 
    end
  end


end


