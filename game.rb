
#################

# EVERYTHING IS HERE RIGHT NOW

#################


#objects that you hold: array or hash
#function to pick up said object
#function to pick up all objects in room
#func to display all objects with you.
## diff func in room's Class to display all objects available
# each object is an Object with actions that can be performed on it and other parameters (line ON/OFF)
#health: floating 0-1

# each object has a weight (as in mass) associated with limiting the amount of objects that can be carried by the One at any given time. Overly heavy objects can only moved. Define variable: move/pickup/none.

#dig-able feature some other time

require_relative 'lexer/scanner.rb'
require_relative 'execute/execute.rb'

class Character

  attr_reader :health         
  
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



 # TO DO
 # *write methods for scanning inputs

################################################################################
      
$runner = Character.new

$runner.change_health(-0.5)
$runner.display_health

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

puts
$current_room = $rooms[:LivingRoom]

p $current_room

puts
$current_room = $rooms[:LivingRoom]
p $current_room

puts

p $runner

$runner.pick_item(:lantern)

p $current_room
p $runner

$runner.drop_item(:lantern)

p $current_room
p $runner

$runner.drop_item(:lantern)
$runner.pick_item(:lantern)
$runner.pick_item(:lantern)
# Well, pick and drop works!

$current_room.move(:N)
$current_room.move(:S)
$runner.drop_item(:lantern)
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
  input = STDIN.gets.chomp

  if input == "quit"
    break
  end
  
  p understand(input)
  execute(understand(input))

  if $runner.health < 0
    puts "Too low health. You die."
  end
end
  
puts "Thank you for playing The Adventure."
# output score or level too
puts
