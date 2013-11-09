$verb_list = {
  :go => [:N, :E, :S, :W, :NE, :SE, :SW, :NW],
  :enter => [:house], # review having this around
  :take => [:lantern], #don't forget those pesky commas
  :look => [:around, :lantern] # look around, look at lantern. Remember the "at" will be removed
}

$prepositions_list = ["the", "at", "on", "under", "above", "in", "with"]

Pair = Struct.new(:verb, :token)

def understand(input)
  # assuming no punctuations in input. Ideally, remove it before this stage
  # Empty input
  input = input.strip.downcase # deal with punctuation
  
  if input == ""
    return Pair.new(:gibberish, :empty)
  end

  if input == "hello" || input == "hi" || input == "hey"
    return Pair.new(:say, :hello)
  end
  # SHORTCUTS

  




  
    # get full sentences to work. Make it for shortcuts later
  # remove all prepositions that do not help your cause from the array
  verb, noun = get_verb_noun_tokens(input.split(' ')) # write function that takes input[0] and returns 'go' for 'go', 'head', 'enter', 'walk east' etc.
  # has to detect what the word means and gives a proper token (see verb_list)
  
  if $verb_list.include?(verb) && $verb_list[verb].include?(noun) #is verb_list.include necessary?
    return Pair.new(verb, noun)
  end
  
  return Pair.new(:gibberish, noun) # Output something like I could not understand "<token>"

  # in the execute function, if noun, say "<noun> used in a way I don't understand"
end

# Do something about "north east". Perhaps the whole remaining part of the array after a "go"

def tokenize(noun)
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
  if noun == "northeast" || noun == "north-east"
      
  if noun == "lantern"
    return :lantern
  end
  if noun == "around"
    return :around
  end
  return nil
end

def remove_preps(input)
  $prepositions_list.each do |prep|
    input.delete(prep)
  end
  return input
end

def get_verb_noun_tokens(input) #returns [:verb, :noun]
  input = remove_preps(input) #improve this
  verb = nil
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
  
  if input.first == "pick"
    verb = :take
    if input[1...input.length] == "up"
      noun = tokenize(input[2])
      if noun
        return :take, noun
      else
        return :gibberish, input[2].to_sym
      end
    else
      noun = tokenize(1...input.length)
      if noun
        return :take, noun
      else
        return :gibberish, noun
      end
    end
  end
end
# currently, "go the north" is valid input and will return
# :go, :N since the prepositions are removed much earlier.

# Consider calling the prepositions removal function
# in the get_verb_noun_tokens function instead
