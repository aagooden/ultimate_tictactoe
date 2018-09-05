class Player

    attr_accessor :name, :piece, :type

    def initialize(name, type, piece)
        @piece = piece
        @name = name
        @score = 0
        @type = type
    end

    def increase_score
        @score +=1
    end

    def score
        @score
    end

    def choose_move(game, board)
        @type.choose_move(game, board)
    end

end
