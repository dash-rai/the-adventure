#objects that you hold: array or hash
#function to pick up said object
#function to pick up all objects in room
#func to display all objects with you.
## diff func in room's Class to display all objects available
# each object is an Object with actions that can be performed on it and other parameters (line ON/OFF)
#health: floating 0-1

# each object has a weight (as in mass) associated with limiting the amount of objects that can be carried by the One at any given time. Overly heavy objects can only moved. Define variable: move/pickup/none.

#dig-able feature some other time

class Character

  def initialize
    @items = []
    @health = 1
  end

  def list_items
    if @items.empty?
      puts "You aren't carrying anything."
      return
    end
    puts "You are currently carrying: "
    @items.each do |item|
      print '* '
      puts item.attributes['name']
    end
  end

  def pick_item(item_name)
    # check if character already has item
    @items.each do |item|
      if item.attributes['name'] == item_name
        puts "You already have the %s." % item_name
        return
      end
    end
    # if room has item, pick it up
    $current_room.items.each do |item|
      if item.attributes['name'] == item_name
        @items.push item
        puts "You picked up the %s" % item.attributes['name']
        $current_room.items.delete item
        return
      end
    end
    # item neither in room nor with you
    puts "The %s is not in the room" % item_name
  end

  def drop_item(item_name)
    @items.each do |item|
      if item.attributes['name'] == item_name
        $current_room.items.push item
        puts "You are no longer carrying the %s" % item.attributes['name']
        @items.delete(item)
        return
      end
    end
    puts "The %s is not with you" % item_name
  end
  
  def change_health(change) #negative change to cause damage
    if @health + change > 1
      @health = 1
    elsif @health + change <= 0
      dead()
    else
      @health += change
    end
  end

  def display_health
    puts "Health: %d%" % (@health * 100).to_i
  end

  
end

class Item

  def initialize(name, weight, onoff, pickable)
    @attributes = {
      'name' => name,
      'weight' => weight,
      'onoff' => onoff,
      'pickable' => pickable
    }
    if @attributes['onoff']
      @on = FALSE
    end
  end

  def turn_onoff(bool)
    if @attributes['onoff']
      @on = bool
    end
  end  
  
  attr_accessor :attributes

end

class Room
  attr_accessor :items
  
  def move(direction)
    case direction
    when :N
      if $rooms.include? @paths[:N]
        $current_room = $rooms[@paths[:N]]
        $current_room.description
      else
        puts "You can't go there."
      end
    when :E
      if $rooms.include? @paths[:E]
        $current_room = $rooms[@paths[:E]]
        $current_room.description
      else
        puts "You can't go there."
      end
    when :S
      if $rooms.include? @paths[:S]
        $current_room = $rooms[@paths[:S]]
        $current_room.description
      else
        puts "You can't go there."
      end
    when :W
      if $rooms.include? @paths[:W]
        $current_room = $rooms[@paths[:W]]
        $current_room.description
      else
        puts "You can't go in that direction."
      end
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

 # TO DO
 # *write methods for scanning inputs

def understand(input)

  if input.scan(/w+/)
    puts "Word"
  end
  
end

################################################################################
      
one = Character.new
one.change_health(-0.5)
one.display_health

i = Item.new(:lantern, 0.1, TRUE, TRUE)
puts i.attributes

p i

i.turn_onoff true

p i

# testing add and drop. Person to room and vice-versa

$rooms = {
  :LivingRoom => Living_Room.new,
  :Kitchen => Living_Room.new # for testing. REMOVE
  }


$current_room = $rooms[:LivingRoom]

p $current_room
p one

one.pick_item(:lantern)

p $current_room
p one

one.drop_item(:lantern)

p $current_room
p one

one.drop_item(:lantern)
one.pick_item(:lantern)
one.pick_item(:lantern)
# Well, pick and drop works!

$current_room.move(:N)
$current_room.move(:S)

prompt = '> '
puts '*' * 80
puts "Welcome!"
puts "Enter \"quit\" to exit game."
puts '*' * 80
puts
while true
  print prompt

  # A ctrl-d doesn't play well. Reports an error. Perhaps you could catch that and exit nicely.
  # Right now, the error handling below takes care of that, but doesn't look like the best way since
  # any error will go to this.
  begin
    input = STDIN.gets.chomp.strip.downcase
    if input == "quit"
      puts "Thank you for playing. Goodbye!"
      break
    end

    # if input == "go north"
    #   $current_room.move(:N)
    # end

    # execute(understand(input))
    
    understand(input)
  rescue
    puts "Error."
    puts "Thank you for playing. Goodbye!"
    break
  end
end
  
