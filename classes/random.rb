class Random


  def choose_move(game, board)
    move = (board.check_available_spaces).sample
    return move
  end


end
