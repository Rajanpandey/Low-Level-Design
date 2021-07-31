class SnakeAndLadderBoard
    attr_accessor :snakes, :ladders, :player_pieces
    attr_reader :size

    def initialize(size)
        @size = size
        @snakes = snakes
        @ladders = ladders
        @player_pieces = Hash.new
    end
end
