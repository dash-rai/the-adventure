require "test/unit"
require_relative '../lexer/scanner.rb'
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

  end
  
  def test_directions
    @north_test_strings.each do |input|
      assert_equal(:N, understand(input), "Input: \"" + input + "\"")
    end

    @southeast_test_strings.each do |input|
      assert_equal(:SE, understand(input), "Input: \"" + input + "\"")
    end
  end
  
end
