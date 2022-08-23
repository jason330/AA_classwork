# enumerables.rb
class Array

    def my_each(&blk)
        i = 0
        while i < self.length
            blk.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&blk)
        selected = []
        self.my_each do |ele|
            selected << ele if blk.call(ele)
        end
        selected
    end

    def my_reject(&blk)
        rejected = []
        self.my_each do |ele|
            rejected << ele if !blk.call(ele)
        end
        rejected
    end

    def my_any?(&blk)
        self.my_each do |ele|
            return true if blk.call(ele)
        end
        false
    end

    def my_all?(&blk)
        self.my_each do |ele|
            return false if !blk.call(ele)
        end
        true
    end

    def my_flatten
        flattened_arr = []
        self.each do |ele|
            if !ele.kind_of?(Array)
                flattened_arr += [ele]
            else
                flattened_arr += ele.my_flatten
            end
        end
        flattened_arr
    end

    def my_zip(*arg)
        #new_arr = Array.new(self.length) { Array.new(arg.length + 1)}
        new_arr = []

        (0...self.length).each do |i|
            sub_arr = []
            sub_arr << self[i] 
            arg.each do |input_arr|
                sub_arr << input_arr[i]
            end 
            new_arr << sub_arr
        end
        new_arr

    end

    def my_rotate(number=1)
        new_arr = self.map { |ele| ele }
        if number > 0
            number.times do
                ele = new_arr.shift
                new_arr.push(ele)
            end
        else
            (-number).times do
                ele = new_arr.pop
                new_arr.unshift(ele)
            end
        end
        new_arr
    end

    def my_join(separator = "")
        self.join(separator)
    end

    def my_reverse
        reversed = []
        i = self.length - 1
        while i >= 0
            reversed << self[i]
            i -= 1
        end
        reversed
    end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]