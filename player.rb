class Player

    attr_accessor :name, :piece, :type

    def initialize(name, type, piece, game)

        @piece = piece
        @name = name
        @score = 0
        
        @game = game

        case type
        when "random"
            @type = Random.new
        when "sequencial"
            @type = Sequencial.new
        when "human"
            @type = Human.new
        when "unbeatable"
            @type = Unbeatable.new(piece)
        end

    end

    def increase_score
        @score +=1
    end

    def score
        @score
    end

    def choose_move
        @type.choose_move(@game)
    end

end
