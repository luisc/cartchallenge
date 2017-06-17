class Adjustment
  
  attr_accessor :label
  attr_accessor :amount
  attr_accessor :quantity
  
  def subtotal
    amount * quantity
  end
  
end