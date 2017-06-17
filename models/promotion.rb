class Promotion
  
  attr_accessor :amount
  attr_accessor :description
  attr_accessor :triggers
  attr_accessor :line_items
  attr_accessor :results
  
  def initialize
    self.triggers = []
  end
  
  def add_trigger(item, quantity)
    self.triggers << { item: item, quanity: quantity }
  end
  
  def add_line_items(line_items)
    self.line_items = line_items
  end
  
  def add_adjustment(description, amount)
    self.description = description
    self.amount = amount
  end
  
  def apply
    { description: self.description, amount: self.action.call }
  end
  
  def qualifies?
    false
  end
  
end