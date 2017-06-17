class Order
  
  attr_accessor :line_items
  attr_accessor :customer
  
  def initialize
    self.line_items = {}
  end
  
  def add_line_item(item)
    
    if self.line_items[item.id]
      self.line_items[item.id].quantity += 1
    else
      li = LineItem.new
      li.item = item
      li.price = item.price
      li.quantity = 1
      li.order = self
      
      self.line_items[item.id] = li
    end
    
  end
  
  def total
    self.line_items.inject(0) do |result, line_item|
      result + line_item.subtotal
    end
  end
  
  def count_line_items
    line_items.length
  end
  
  def count_all_line_items
    line_items.inject(0) do |result, line_item|
      result + line_item.quantity
    end
  end
  
end