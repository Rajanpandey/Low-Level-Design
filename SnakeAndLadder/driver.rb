require_relative 'Models/snake.rb'
require_relative 'Models/ladder.rb'
require_relative 'Models/player.rb'
require_relative 'Services/snake_and_ladder_service.rb'

class Driver
    def main
        snakes = []
        ladders = []
        players = []

        if ARGV[0]
            line_number = 0

            file = File.readlines(ARGV[0])
            no_of_snakes = file[line_number].to_i
            for i in ((line_number + 1)..(line_number + no_of_snakes))
                snake_input = file[i].split.map(&:to_i)
                snake = Snake.new(snake_input[0], snake_input[1])
                snakes << snake
                line_number += 1
            end

            line_number += 1
            no_of_ladders = file[line_number].to_i
            for i in ((line_number + 1)..(line_number + no_of_ladders))
                ladder_input = file[i].split.map(&:to_i)
                ladder = Ladder.new(ladder_input[0], ladder_input[1])
                ladders << ladder
                line_number += 1
            end

            line_number += 1
            no_of_players = file[line_number].to_i
            player_input = file[line_number + 1].split
            player_input.each do |player|
                players << Player.new(player)
            end
        else
            no_of_snakes = gets.chomp.to_i
            for i in (1..no_of_snakes)
                snake_input = gets.chomp.split.map(&:to_i)
                snake = Snake.new(snake_input[0], snake_input[1])
                snakes << snake
            end

            no_of_ladders = gets.chomp.to_i
            for i in (1..no_of_ladders)
                ladder_input = gets.chomp.split.map(&:to_i)
                ladder = Ladder.new(ladder_input[0], ladder_input[1])
                ladders << ladder
            end

            no_of_players = gets.chomp.to_i
            player_input = gets.chomp.split
            player_input.each do |player|
                players << Player.new(player)
            end
        end

        snake_and_ladder_service = SnakeAndLadderService.new
        snake_and_ladder_service.set_snakes(snakes)
        snake_and_ladder_service.set_ladders(ladders)
        snake_and_ladder_service.set_players(players)

        snake_and_ladder_service.start_game
    end
end

driver = Driver.new.main
