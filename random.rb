class Random


  def choose_move(game)
    move = (game.board.check_available_spaces).sample
    return move
  end


end
