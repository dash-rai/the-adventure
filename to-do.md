** Make a room-generator script that takes plain English input and spits out room objects or classes.**

** Clean up the code a bit**

** Write a scanner that will understand user input and call the appropriate methods.**
Let it return tokens and an associated value. Something like (direction, north)

** Write a 'death' method that will be invoked by a health checker method.**
Include health checker in the main program so that it will loop after every input.
Perhaps something more efficient would do too...

** Add in fights with dragons and what not :') **
** Lexer/Parser**
  Splits sentence into an array of words after removing any punctuations
  You could throw an error if you see a number in there unless you were expecting one
  Scans through and removes words like "a", "the" and description words like "red"
  Once that is done, follow a [verb][noun] pattern to understand the input
  Eg:
  "Go through the door."
  ["Go", "through", "the", "door"]
  ["Go", "door"]
  execute whatever
  
  To remove words like "the", see if the word exists in the verb or noun lists and if not, remove it
  You might also have to deal with repeated words
  Go Go through the door will easily do something stupid if not handled properly
  A simple comparison between a unique array and the original AFTER removing the "the"s etc should work for that

  Return something like (direction, north) from the lexer.
  Also, Zed suggests: 
  Pair = Struct.new(:token, :word)
  first_word = Pair.new("direction", "north")
  second_word = Pair.new("verb", "go")
  sentence = [first_word, second_word]
  
  but I don't think that's quite necessary. Perhaps just return a struct with (direction, north)

#H1
*italics*
**bold**
###haha
