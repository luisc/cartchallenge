class Adjustment
  
  attr_accessor :label
  attr_accessor :amount
  attr_accessor :quantity
  
  def initialize(attrs = {})
    self.label = attrs[:label]
    self.amount = attrs[:amount]
    self.quantity = attrs[:quantity]
  end
  
  def subtotal
    self.amount * self.quantity
  end
  
end