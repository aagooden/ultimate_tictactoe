
class Game

  attr_accessor :current_player, :player1, :player2, :board

  def initialize(player1_name, player2_name, player1_type, player2_type, player1_piece, player2_piece, goes_first, size)

      @board = Board.new(size)
      @player1 = Player.new(player1_name, player1_type, player1_piece, self)
      @player2 = Player.new(player2_name, player2_type, player2_piece, self)
      goes_first == "player1" ? @current_player = @player1 : @current_player = @player2 
      @size = size
  end

  def change_turn
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def game_over
    if @board.check_tie || @board.check_winner
      return true
    else
      return false
    end
  end

  def play_again(turn)
    @board = Board.new(@size)
    @current_player = turn == "player1" ? @player1 : @player2
  end

  def game_won_by(piece)
    @board.overall_status().each do |group|
      return true if group.count(piece) == self.board.size
    end
    false
  end

end
