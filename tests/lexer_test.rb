require_relative '../lexer/scanner.rb'
require 'test/unit'


class Tests < Test::Unit::TestCase

  @@s = "S"
  
  def setup
    # @north_test_strings = [
    #                        "go north",
    #                        "north",
    #                        "head north",
    #                        "n"
    #                       ]
    # @southeast_test_strings = [
    #                            "go southeast",
    #                            "head southeast",
    #                            "south east",
    #                            "go south-east",
    #                            "head south east",
    #                            "south-east",
    #                            "go south east",
    #                            "southeast",
    #                            "head south-east"
    #                            ]

    # @take_test_strings = [
    #                       "pick up lantern",
    #                       "take lantern",
    #                       "take the lantern",
    #                       "pick up the lantern",
    #                       "pick lantern up"
    #                      ]
                          
    # @gibberish_test_strings = [
    #                            "don't go there",
    #                            "okay",
    #                            "pick something",
    #                            "take something",
    #                            "head eastnorth",
    #                            "take a look at me!"
    #                           ]

    @full_direction_strings = {
      "Go north" => :N,
      "go south" => :S,
      "head east" => :E,
      "walk west" => :W,
      "go north-east" => :NE,
      "head south-east" => :SE,
      "walk north-west" => :NW,
      "go northeast" => :NE,
      "HEAD SOUTHWEST" => :SW,
      "go up" => :U,
      "go down" => :D,
      "walk up" => :U,
      "head up" => :U,
      "go upstairs" => :U,
      "go downstairs" => :D,
      "  go downstairs" => :D,
      " go    north-east " => :NE
    }

    # make "enter house" checks


    
    @direction_shortcut_strings = {
      "north" => :N,
      "south" => :S,
      "east" => :E,
      "west" => :W,
      "northwest" => :NW,
      "southeast" => :SE,
      "north-east" => :NE,
      "south-west" => :SW,
      "up" => :U,
      "down" => :D,
      " DOWN " => :D
    }

    @pick_lantern_strings = [
                             "pick up lantern",
                             "pick up the lantern",
                             "pick lantern",
                             "take lantern",
                             "take the lantern",
                             "pick lantern up",
                             "pick the lantern up." # there's a period at the end of that.
                            ]
    @look_strings = {
      "look" => :around,
      "look around" => :around,
      "look at lantern" => :lantern,
      "look at the lantern" => :lantern,
      "l" => :around
    }

    @gibberish_strings = {
      "" => :empty,
    }
    # gibberish returns need to improved
    #test gibberish strings too
  end

  def test_simple_full_directions
    @full_direction_strings.each do |input, result|
      assert_equal(Pair.new(:go, result), understand(input), input)
    end
  end

  def test_shortcuts
    @direction_shortcut_strings.each do |input, result|
      assert_equal(Pair.new(:go, result), understand(input), input)
    end
  end

  def test_take
    @pick_lantern_strings.each do |input|
      assert_equal(Pair.new(:take, :lantern), understand(input), input)
      assert_equal(Pair.new(:take, :all), understand("take"))
    end
  end

  def test_look
    @look_strings.each do |input, result|
      assert_equal(Pair.new(:look, result), understand(input), input)
    end
  end

  def test_gibberish
    @gibberish_strings.each do |input, result|
      assert_equal(Pair.new(:gibberish, result), understand(input), input)
    end
  end
  
end
