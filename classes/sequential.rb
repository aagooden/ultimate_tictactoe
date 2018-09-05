class Sequential


  def choose_move(game, board)
    move = (board.check_available_spaces)[0]
    return move
  end

end
