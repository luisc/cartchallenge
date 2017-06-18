class Promotion
  
  attr_accessor :qualifiers
  attr_accessor :effects
  attr_accessor :results
  attr_accessor :apply_amount_for_each_match
  
  def initialize(attrs = {})
    self.qualifiers = {}
    self.effects = {}
    self.apply_amount_for_each_match = attrs[:apply_amount_for_each_match].nil? ? true : attrs[:apply_amount_for_each_match]
  end
  
  def add_qualifier(item, quantity)
    self.qualifiers[item] = quantity
  end
  
  def add_effect(label, amount)
    self.effects[label] = amount
  end
  
end