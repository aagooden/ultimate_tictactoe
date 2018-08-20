
class Game

  attr_accessor :current_player, :player1, :player2, :board

  def initialize(player1_name, player2_name, player1_type, player2_type, player1_piece, player2_piece, goes_first, size)
      @board = Board.new(size)
      @player1 = Player.new(player1_name, player1_type, player1_piece, self)
      @player2 = Player.new(player2_name, player2_type, player2_piece, self)
      goes_first == "player1" ? @current_player = @player1 : @current_player = @player2 
  end

  def change_turn
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def update_game_status(move)
    if @board.check_position(move) == false
      return "no_dice"
    else
      @board.change_state(@current_player.piece, move)
    end

    if @board.check_winner
      @current_player.increase_score
      return "winner"
    elsif @board.check_tie
      return "tie"
    else
      @current_player = @current_player ==  @player1 ? @player2 : @player1
      @turn = @turn == "player1" ? "player2" : "player1"
      # puts "TURN AT THE END IS #{@turn}"
    end
  end

  def game_over
    if @board.check_tie || @board.check_winner
      return true
    else
      return false
    end
  end


  def play_again(turn)
    @board = Board.new
    @board.reset
    @turn = turn
    if turn == "player1" || turn == "Computer1"
      @current_player = @player1
    else
      @current_player = @player2
    end
  end

  def game_won_by(piece)
    @board.overall_status().each do |group|
      return true if group.count(piece) == 3
    end
    false
  end

end
