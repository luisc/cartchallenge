class LineItem
  
  attr_accessor :item
  attr_accessor :price
  attr_accessor :quantity
  
  def initialize(attributes)
    self.item = attributes[:item] || Item.new
    self.price = self.item.price
    self.quantity = attributes[:quantity] || 1
  end
  
  def subtotal
    self.quantity * self.price
  end
  
end