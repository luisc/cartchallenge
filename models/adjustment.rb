class Adjustment
  
  attr_accessor :label
  attr_accessor :amount
  attr_accessor :quantity
  attr_accessor :item
  
  def subtotal
    amount * quantity
  end
  
end