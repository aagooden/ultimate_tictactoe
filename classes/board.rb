class Board

    attr_accessor :state, :combos, :size

    def initialize(size)
        @state = (0...size*size).to_a
        @combos = create_combos(size)
        @size = size
    end

    def create_combos(size)
      combos = []
      diag_1 = []
      diag_2 = []
      horizontals = ((0..((size * size)-1)).to_a).each_slice(size).to_a
      verticals = horizontals.transpose

      for x in (0...(size))
        diag_1.push(x * (size + 1))
      end

      for x in (1..size)
        diag_2.push(x * (size-1))
      end
      diag_2.reverse!
      horizontals.each{|h| combos.push(h)}
      verticals.each{|v| combos.push(v)}
      combos.push(diag_1)
      combos.push(diag_2)
      return combos
    end

    def combos
      @combos = @combos
    end

    def overall_status
      overall_status = []
      combos = @combos.dup
        combos.each do |group|
          temp = []
            group.each do |position|
              temp.push(@state[position])
            end
            overall_status.push(temp)
        end
        return overall_status
    end

    def change_state(position, piece)
        @state[position] = piece
    end

    def check_position(position)
        if @state[position] == "X" || @state[position] == "O"
            false
        else
            true
        end
    end

    def check_available_spaces
      available_spaces = []
      self.state.each do |space|
        available_spaces.push(space) if space.is_a?(Integer)
      end
      return available_spaces
    end

    def check_tie
        @state.all? {|i| i.is_a?(String) }
    end

    def check_winner
      winner = false
      overall_status().each do |group|
        if group.count("X") == self.size || group.count("O") == self.size
            winner = true
        end
      end
      return winner
    end

  def game_over
    if self.check_tie || self.check_winner
      return true
    else
      return false
    end
  end

  def game_won_by(piece)
    @board.overall_status().each do |group|
      return true if group.count(piece) == self.size
    end
    false
  end


end
