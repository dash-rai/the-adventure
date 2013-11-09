require_relative '../lexer/scanner.rb'
require 'test/unit'

class Tests < Test::Unit::TestCase

  def setup
    @north_test_strings = [
                           "go north",
                           "north",
                           "head north",
                           "n"
                           ]
    @southeast_test_strings = [
                               "go southeast",
                               "head southeast",
                               "south east",
                               "go south-east",
                               "head south east",
                               "south-east",
                               "go south east",
                               "southeast",
                               "head south-east"
                               ]

    @take_test_strings = [
                          "pick up lantern",
                          "take lantern",
                          "take the lantern",
                          "pick up the lantern",
                          "pick lantern up"
                         ]
                          
    @gibberish_test_strings = [
                               "don't go there",
                               "okay",
                               "pick something",
                               "take something",
                               "head eastnorth",
                               "take a look at me!"
                              ]
                               
  end

  def test_directions
    @north_test_strings.each do |input|
      assert_equal(Pair.new(:go, :N), understand(input), "Input: \"" + input + "\"")
    end

    @southeast_test_strings.each do |input|
      assert_equal(Pair.new(:go, :SE), understand(input), "Input: \"" + input + "\"")
    end
  end

  def test_take
    @take_test_strings.each do |input|
      assert_equal(Pair.new(:take, :lantern), understand(input), "Input: \"" + input + "\"")
    end
  end

  def test_gibberish
    @gibberish_test_strings.each do |input|
      assert_equal(Pair.new(:gibberish, :lantern).verb, understand(input).verb, "Input: \"" + input + "\"")
    end
  end

      
end

