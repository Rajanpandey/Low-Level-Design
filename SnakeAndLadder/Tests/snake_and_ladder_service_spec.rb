require_relative '../Models/snake.rb'
require_relative '../Models/ladder.rb'
require_relative '../Models/player.rb'
require_relative '../Services/snake_and_ladder_service.rb'

describe "#Driver" do
    snakes = [Snake.new(11, 42)]
    ladders = [Ladder.new(36, 58)]
    players = [Player.new('Rajan'), Player.new('Rajat')]

    snake_and_ladder_service = SnakeAndLadderService.new
    snake_and_ladder_service.set_snakes(snakes)
    snake_and_ladder_service.set_ladders(ladders)
    snake_and_ladder_service.set_players(players)

    it "returns a winner from players list" do
        expect(players).to include(snake_and_ladder_service.start_game)
    end
end
