class Sequential


  def choose_move(game)
    move = (game.board.check_available_spaces)[0]
    return move
  end

end
