class Order
  
  attr_accessor :line_items
  
  def initialize
    self.line_items = []
  end
  
  def add_line_item(item)
    self.line_items << item
  end
  
  def total
    self.line_items.inject(0) do |result, line_item|
      result + line_item.subtotal
    end
  end
  
end