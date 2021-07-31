class DiceService
    attr_accessor :snakes, :ladders, :playerPieces

    def roll()
        rand(1..6)
    end
end
