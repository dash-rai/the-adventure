
def understand(input)

  
  # input = input.chomp.strip.downcase
  # if input.scan(/w+/)
  #   puts "Word"
  # end
  
  #   if input == "quit"
  #     puts "Thank you for playing. Goodbye!"
  #     break
  #   end

  #   # if input == "go north"
  #   #   $current_room.move(:N)
  #   # end

  #   # execute(understand(input))
    
  #   understand(input)
  # rescue
  #   puts "Error."
  #   puts "Thank you for playing. Goodbye!"
  #   break

  input = input.chomp.strip.downcase

  if input == ""
    return nil
  end
  
  if input == "n" || !input.scan(/^go\s+north$/).empty?
    return :N
  end

  if input == "e" || !input.scan(/^go\s+east$/).empty?
    return :E
  end
  
  if input == "s" || !input.scan(/^go\s+south$/).empty?
    return :S
  end

  if input == "w" || !input.scan(/^go\s+west$/).empty?
    return :W
  end

  if input == "ne" || !input.scan(/^northeast$|^north-east$|^north\s+east$|^go\s+northeast$|^go\s+north-east$|^go\s+north\s+east$/).empty?
    return :NE
  end

  if input == "se" || !input.scan(/^southeast$|^south-east$|^south\s+east$|^go\s+southeast$|^go\s+south-east$|^go\s+south\s+east$/).empty?
    return :SE
  end

  if input == "sw" || !input.scan(/^southwest$|^south-west$|^south\s+west$|^go\s+southwest$|^go\s+south-west$|^go\s+south\s+west$/).empty?
    return :SW
  end

  if input == "nw" || !input.scan(/^northwest$|^north-west$|^north\s+west$|^go\s+northwest$|^go\s+north-west$|^go\s+north\s+west$/).empty?
    return :NW
  end

  if input == "u"
    return :U
  end
  if input == "d"
    return :D
  end
  
  return :gibberish
  
end

