require_relative '../Models/snake.rb'
require_relative '../Models/ladder.rb'
require_relative '../Models/player.rb'
require_relative '../Models/snake_and_ladder_board.rb'
require_relative '../Exceptions/bad_request_exception.rb'
require_relative 'dice_service.rb'

class SnakeAndLadderService
    DEFAULT_BOARD_SIZE = 100
    DEFAULT_NO_OF_DICE = 1

    @@initial_number_of_players = 0
    @@players = Queue.new
    @@should_continue_till_last_player = false
    @@should_allow_multiple_dice_roll_in_six = false

    def initialize(board_size = DEFAULT_BOARD_SIZE)
        @snake_and_ladder_board = SnakeAndLadderBoard.new(board_size)
        @players = []
        @no_of_dices = DEFAULT_NO_OF_DICE
    end

    def set_snakes(snakes)
        @snake_and_ladder_board.snakes = snakes
    end

    def set_ladders(ladders)
        @snake_and_ladder_board.ladders = ladders
    end

    def set_players(players)
        raise BadRequestException if players.empty?

        @players = []
        @@initial_number_of_players = players.size
        player_pieces = {}

        players.each do |player|
            @players << player
            player_pieces[player.id] = 0
        end

        @snake_and_ladder_board.player_pieces = player_pieces
    end

    def get_new_position_after_going_through_board(new_position)
        previous_position = nil

        loop do
            previous_position = new_position

            @snake_and_ladder_board.snakes.each do |snake|
                new_position = snake.stop if snake.start == new_position
            end

            @snake_and_ladder_board.ladders.each do |ladder|
                new_position = ladder.stop if ladder.start == new_position
            end

            break if new_position == previous_position
        end

        new_position
    end

    def move_player(player, positions)
        previous_position = @snake_and_ladder_board.player_pieces[player.id]
        new_position = previous_position + positions
        board_size = @snake_and_ladder_board.size

        new_position = (new_position > board_size) ? previous_position : get_new_position_after_going_through_board(new_position)

        @snake_and_ladder_board.player_pieces[player.id] = new_position

        puts "#{player.name} rolled a #{positions} and moved from #{previous_position} to #{new_position}"
    end

    def get_total_value_after_dice_rolls
        DiceService.new.roll
    end

    def has_player_won?(player)
        player_position = @snake_and_ladder_board.player_pieces[player.id]
        winning_position = @snake_and_ladder_board.size

        player_position == winning_position
    end

    def is_game_completed?
        curr_num_of_players = @players.size
        curr_num_of_players < @@initial_number_of_players
    end

    def start_game
        while !is_game_completed?
            total_dice_value = get_total_value_after_dice_rolls
            curr_player = @players.pop
            move_player(curr_player, total_dice_value)

            if (has_player_won?(curr_player))
                puts "#{curr_player.name} wins the game!"
                @snake_and_ladder_board.player_pieces.delete(curr_player.id)
                return curr_player
            else
                @players.unshift(curr_player)
            end
        end
    end
end
