#player.rb

class Player
    def initialize(name)
        @name = name
    end

    def guess
        puts "enter a letter: "
        user_input = gets.chomp
    end
end