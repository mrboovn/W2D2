require_relative "room"
require "byebug"

class Hotel

    attr_reader :rooms

    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end 
    
    def name
        new_name = []
        words = @name.split(" ")
        words.each {|word| new_name << word.capitalize}
        new_name.join(" ")
    end


    def room_exists?(room_name)
        return true if @rooms.keys.include?(room_name)
        false
    end

    def check_in(guest, room)
        if !room_exists?(room) 
            puts "sorry, room does not exist"
            return false
        end
       
        if @rooms[room].add_occupant(guest) 
            puts "check in successful"
        else
            puts "sorry, room is full"
        end
    end

    def has_vacancy?
        rooms_arr = @rooms.values
        return true if rooms_arr.any? {|room| !room.full?}
        false
    end

    def list_rooms
        @rooms.each do |name, room|
            puts "#{name} #{room.available_space}"
        end
    end
end
