
class Room
  attr_accessor :items
  
  def move(direction)
    if $rooms.include? @paths[direction]
      $current_room = $rooms[@paths[direction]]
      $current_room.description
    else
      puts "You can't go there."
    end
  end
  
end

class Living_Room < Room

  def initialize
    @items = [ i = Item.new(:lantern, 0.1, true, true) ]
    @paths = {
      :N => :Kitchen
    }
    @lit = TRUE
  end
  
  def description
    puts "This is the living room. [more desc]"
    @items.each do |item|
      puts "There is a #{item.attributes['name']} here"
    end
  end

end

