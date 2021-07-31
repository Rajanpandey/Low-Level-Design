require_relative '../Models/snake.rb'
require_relative '../Models/ladder.rb'
require_relative '../Models/player.rb'
require_relative 'snake_and_ladder_service.rb'

class Driver
    def main
        no_of_snakes = gets.chomp.to_i
        snakes = []
        for i in (1..no_of_snakes)
            snake = Snake.new(gets.chomp.to_i, gets.chomp.to_i)
            snakes << snake
        end

        no_of_ladders = gets.chomp.to_i
        ladders = []
        for i in (1..no_of_ladders)
            ladder = Ladder.new(gets.chomp.to_i, gets.chomp.to_i)
            ladders << ladder
        end

        no_of_players = gets.chomp.to_i
        players = []
        for i in (1..no_of_players)
            player = Player.new(gets.chomp)
            players << player
        end

        snake_and_ladder_service = SnakeAndLadderService.new
        snake_and_ladder_service.set_snakes(snakes)
        snake_and_ladder_service.set_ladders(ladders)
        snake_and_ladder_service.set_players(players)

        snake_and_ladder_service.start_game
    end
end

driver = Driver.new.main
