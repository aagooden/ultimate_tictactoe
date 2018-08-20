class Random


  def choose_move(game)
    move = (game.board.check_available_spaces).sample
    puts "MOVE FROM RANDOM IS #{move}"
    puts "Player from random is #{game.current_player.piece}"
    return move
  end


end
