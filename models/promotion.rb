class Promotion
  
  attr_accessor :qualifiers
  attr_accessor :effects
  attr_accessor :results
  
  def initialize
    self.qualifiers = []
  end
  
  def add_qualifier(item, quantity)
    self.qualifiers << { item: item, quanity: quantity }
  end
      
end