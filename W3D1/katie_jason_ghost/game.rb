#game.rb
class Game

    attr_reader :current_player, :previous_player

    def initialize(name1, name2)
        @player_1 = Player.new(name1)
        @player_2 = Player.new(name2)
        @fragment = ""
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = {}
        words.each { |word| @dictionary[word] = true }
        @current_player = @player_1
        @previous_player = @player_2
    end

    def next_player!
        if @current_player == @player_1
            @current_player = @player_2
            @previous_player = @player_1
        else
            @current_player = @player_1
            @previous_player = @player_2
        end
    end

    # def take_turn(player)
    #     user_input = gets.chomp
    #     if !alphabet.include?(user_input.downcase) #change
    #         raise "invalid move"
    #     else
    #         @fragment += user_input
    #         if @dictionary.has_key?(@fragment)
    #             puts "you lose"
    #         end
    #     end
    # end

    def take_turn(player)
        user_input = player.guess
        if !valid_play?(user_input)
            raise "invalid move"
        else
            @fragment += user_input
            puts "you lose" if dictionary.has_key?(@fragment)
        end
    end

    def valid_play?(string)
        alphabet = ("a".."z").to_s
        if !alphabet.include?(string.downcase) 
            return false
        end

        @dictionary.each_key do |key|
            if key.start_with?(@fragment + string) 
                return true
            end
        end
        return false 
    end

    def play_round
        self.take_turn(@current_player)
        self.next_player!
    end
end

