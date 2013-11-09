$verb_list = {
  :go => [:N, :E, :S, :W, :NE, :SE, :SW, :NW],
  :enter => [:house], # review having this around
  :take => [:lantern], #don't forget those pesky commas
  :look => [:around, :lantern] # look around, look at lantern. Remember the "at" will be removed
}

$prepositions_list = ["the", "at", "on", "under", "above", "in", "with"]

Pair = Struct.new(:verb, :token)

def understand(input)

  input = input.strip.downcase

  if input == ""
    return Pair.new(:gibberish, :empty)
  end
  
  if input == "hello" || input == "hi" || input == "hey"
    return Pair.new(:say, :hello)
  end

  # SHORTCUTS -- expect these to be accurate enough to do direct comparisons
  #if input == "north"
  
  verb, noun = get_verb_noun_tokens(input.split(' '))

  if !$verb_list.include? verb
    return Pair.new(:gibberish, "I don't know what that means!") #check this
  elsif $verb_list[verb].include? noun
    return Pair.new(verb, noun)
  end

  return Pair.new(:gibberish, "I don't understand " + noun.join)

  #Check the last return

end

# return :gibberish, "ERROR MESSAGE TO DISPLAY" to execute

# returns :verb, :noun if successful
# :gibberish, "nouns" if unsuccessful
def get_verb_noun_tokens(input) 

  verb = nil
  input = remove_preps(input)
  
  
  if input.first == "go" || input.first == "head" || input.first == "walk"
    verb = :go
  elsif input.first == "enter"
    verb = :enter
  elsif input.first == "take"
    verb = :take
  end
  

  if verb
    noun = tokenize(input[1...input.length])
    if noun
      return verb, noun
    else
      return :gibberish, input[1...input.length]
    end
  end

  # PICK LANTERN UP won't work!
  if input.first == "pick"
    
    if input[1] == "up"
      noun = tokenize(input[2...input.length])
      if noun
        return verb, noun
      else
        return :gibberish, input[2...input.length]
      end
    else
      noun = tokenize(input[1...input.length])
      if noun
        return verb, noun
      else
        return :gibberish, input[1...input.length]
      end
    end
  end


  if input.first == "pick"
    input.delete "up"
    verb = :take
    noun = tokenize(input[1...input.length])
    if noun
      return verb, noun
    else
      return :gibberish, input[1...input.length]
    end
  end
  
end

def remove_preps(input)
  $prepositions_list.each do |prep|
    input.delete(prep)
  end
  return input
end

def tokenize(noun)
  noun = noun.join
  if noun == "north" || noun == "n"
    return :N
  end
  if noun == "east" || noun == "e"
    return :E
  end
  if noun == "south" || noun == "s"
    return :S
  end
  if noun == "west" || noun == "w"
    return :W
  end
  if noun == "northeast" || noun == "north-east" || noun == "ne"
    return :NE
  end
  if noun == "southeast" || noun == "south-east" || noun == "se"
    return :SE
  end
  if noun == "southwest" || noun == "south-west" || noun == "sw"
    return :SW
  end
  if noun == "northwest" || noun == "north-west" || noun == "nw"
    return :NW
  end
  if noun == "up" || noun == "u"
    return :U
  end
  if noun == "down" || noun == "d"
    return :D
  end
  if noun == "lantern"
    return :lantern
  end
  if noun == "around"
    return :around
  end
  return nil
end
