
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

