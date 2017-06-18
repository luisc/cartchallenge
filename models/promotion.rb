class Promotion
  
  attr_accessor :qualifiers
  attr_accessor :effects
  attr_accessor :results
  attr_accessor :repeat_application
  
  def initialize(attrs = {})
    self.qualifiers = {}
    self.effects = {}
    self.repeat_application = attrs[:repeat_application].nil? ? true : attrs[:repeat_application]
  end
  
  def add_qualifier(item, quantity)
    self.qualifiers[item] = quantity
  end
  
  def add_effect(label, amount)
    self.effects[label] = amount
  end
  
end