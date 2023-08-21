require 'colorize'
class Game
    attr_accessor :moves, :the_winner, :game_complete
    
    def initialize()
        @moves = ["s", "s", "s", "s", "s", "s", "s", "s", "s"]
        @game_complete = false
        @the_winner = ""
        puts "Welcome to Tic-Tac-Toe. This is a 2 player game, Player1 will be represented\nwith X, and player2 will be represented with O.\nIn order to make a move, choose a number from 1 to 9, with 1 representing\nthe 1st square, 2 representing the 2nd square, and so forth.\n"
    end

    def reset()
        @moves = ["s", "s", "s", "s", "s", "s", "s", "s", "s"]
        @game_complete = false
        @the_winner = ""
    end

    def draw_board()
        moves_temp = @moves.map {|s| s.sub("s", " ")}
        puts  "\n " + moves_temp[0] + " " + "|".gray + " " + moves_temp[1] + " " + "|".gray + " " + moves_temp[2] + " \n" +
              "___ ___ ___\n".gray + 
             "\n " + moves_temp[3] + " " + "|".gray + " " + moves_temp[4] + " " + "|".gray + " " + moves_temp[5] + " \n" +
             "___ ___ ___\n".gray +
             "\n " + moves_temp[6] + " " + "|".gray + " " + moves_temp[7] + " " + "|".gray + " " + moves_temp[8] + " \n\n" 
    
        end

    def get_move(player, move)
        @moves[move.to_i-1] = player.sign
        draw_board()
        self.game_over?(player)
    end

    def game_over?(player)
        if(@moves.join('').match(/#{player.sign}{3}\D\D\D\D\D\D|\D\D\D#{player.sign}{3}\D\D\D|\D\D\D\D\D\D#{player.sign}{3}|#{player.sign}\D\D#{player.sign}\D\D#{player.sign}|#{player.sign}\D\D\D#{player.sign}\D\D\D#{player.sign}|\D\D#{player.sign}\D#{player.sign}\D#{player.sign}\D\D/))
            @the_winner = player.name
            @game_complete = true
            self.display_result()
            self.play_again(player)
        elsif(!@moves.join('').match("s"))
            @the_winner = "Draw"
            @game_complete = true
            self.display_result()
            self.play_again(player)
        end
    
    end

    def display_result()
        if self.the_winner == "Draw"
            puts "It's a Draw!".red
        else
            puts self.the_winner.green + " wins!".green
        end
    end

    def play_again(player)
        puts "Play again? (Y/N)"
        repeat = gets
        while !repeat.match(/Y|y|N|n/)
            puts "Enter a valid selection (Y/N)".red
            repeat = gets
        end
        if (repeat.match(/Y|y/))
            self.reset()
            player.reset()
        end
    end
end

class Player
    @@all_moves = []
    attr_accessor :sign, :name
    
    def initialize(sign, name)
        @sign = sign
        @name = name
    end

    def reset()
        @@all_moves = []
    end

    def self.show_all_moves
        @@all_moves
    end

    def make_move()
        puts "#{@name}: Enter your move".green
        move = gets
        while !move.to_i.between?(1,9)
            puts "Enter a valid move (1-9)".red
            move = gets
        end
        while @@all_moves.join('').match(move)
            puts "This move is already taken, please enter a valid move".red
            move = gets
        end
        @@all_moves.push(move)
        move
    end

end

game = Game.new()
player1 = Player.new("X", "Player1")
player2 = Player.new("O", "Player2")

while !game.game_complete 
    game.get_move(player1, player1.make_move())
    if !game.game_complete && !Player.show_all_moves.empty?
        game.get_move(player2, player2.make_move())
        
    end
    puts Player.show_all_moves
end