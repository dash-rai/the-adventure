Pair = Struct.new(:token, :value)

$verb_list = {
   :go => [:N, :E, :S, :W, :NE, :SE, :SW, :NW],
  :enter => [:house], # review having this around
  :take => [:lantern], #don't forget those pesky commas
  :look => [:around, :lantern] # look around, look at lantern. Remember the "at" will be removed
}

$prepositions_list = ["the", "at", "on", "under", "above", "in", "with", "to"]
$adjectives_list = ["brown", "brass"]

def understand(input_string)
  input_string = input_string.strip.downcase
  #EMPTY input
  if input_string == ""
    return Pair.new(:gibberish, :empty)
  end
  #GREETINGS
  if input_string == "hello" || input_string == "hi" || input_string == "hey"
    return Pair.new(:say, :hello)
  end
  #DIRECTION SHORTCUTS
  if input_string == "north" || input_string == "n"
    return Pair.new(:go, :N)
  end
    if input_string == "east" || input_string == "e"
    return Pair.new(:go, :E)
  end
  if input_string == "south" || input_string == "s"
    return Pair.new(:go, :S)
  end
  if input_string == "west" || input_string == "w"
    return Pair.new(:go, :W)
  end
  if input_string == "up" || input_string == "u"
    return Pair.new(:go, :U)
  end
  if input_string == "down" || input_string == "d"
    return Pair.new(:go, :D)
  end
  if input_string == "northeast" || input_string == "north-east" || input_string == "ne" 
    return Pair.new(:go, :NE)
  end
  if input_string == "southeast" || input_string == "south-east" || input_string == "se"
    return Pair.new(:go, :SE)
  end
  if input_string == "southwest" || input_string == "south-west" || input_string == "sw"
    return Pair.new(:go, :SW)
  end
  if input_string == "northwest" || input_string == "north-west" || input_string == "nw"
    return Pair.new(:go, :NW)
  end

  #GET VERB AND NOUN
  token, value = get_verb_noun(input_string.split(' '))

  # :gibberish token values:
  # :goWHERE
  # :takeWHAT
  # :throwAT?
  # :breakWITH?
  # if verb, but noun == nil, say verb what?
  #I DIDN'T UNDERSTAND THAT!
  if token == :gibberish
    return Pair.new(token, value) # There doesn't appear to be a NOUN? in that sentence
  end
  #RETURN token, value
  if verb_list.include?(token) && verb_list[token].include?(value)
    return Pair.new(token, value)
  else
    return Pair.new(:gibberish, "I don't know how to do that to a %s." % value)
  end
                    
end

def get_verb_noun(input)

  verb = nil
  input = remove_preps_adjs(input)

  if input.first == "go" || input.first == "head" || input.first == "walk"
    verb = :go
  elsif input.first == "enter"
    verb = :enter
  elsif input.first == "take"
    verb = :take
  elsif input.first == "pick"
    input.delete("up") #takes care of things like "pick upX" or "pick X up"
    verb = :take
  end
  
  if verb
    noun = input[1...input.length]
    return verb, symbolisize(noun)
  end
  
  #MULTI NOUN COMMANDS:
  #THROW
  if input.first == "throw"
    if !input.include? "at"
      return :gibberish, :throwAT? #in execute() say "What do you want me to throw noun at?
    end
    noun = input[1..input.index("at")], input[(input.index("at") + 1)...input.length]
    if noun[0] == nil
      return :gibberish, :throwWHAT?
    end
    if noun[1] == nil
      return :gibberish, :throwAT?
    end
    verb = :throw
  end
  
  #BREAK
  if input.first == "break"
    if !input.include? "with"
      return :gibberish, :breakWITH?
    end
    noun = input[1..input.index("at")], input[(input.index("at") + 1)...input.length]
    if noun[0] == nil
      return :gibberish, :breakWHAT?
    end
    if noun[1] == nil
      return :gibberish, :breakWITH?
    end
    verb = :break
  end

  # #TIE
  # if input.first == "tie"
  #   if !input.include? "with"
  # return verb, [symbolisize(noun[0]), symbolisize(noun[1])]
  # #tie rope onto railing
  # #tie sack with rope


  #perhaps do an all-else-fail return here

end
def symbolisize(noun)
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

def remove_preps_adjs(input)
  $prepositions_list.each do |prep|
    input.delete(prep)
  end
  return input
end




        
