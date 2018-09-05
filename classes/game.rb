
class Game

  attr_accessor :current_player, :player1, :player2

  def initialize(goes_first, player1, player2)
    puts "GOES FIRST" *(50)
    p goes_first
    @player1 = player1
    @player2 = player2

      goes_first == "player1" ? @current_player = player1 : @current_player = player2 

  end

  def change_turn
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def play_again(turn)
    @board = Board.new(@size)
    @current_player = turn == "player1" ? @player1 : @player2
  end



end
