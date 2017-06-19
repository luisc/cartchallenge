class Order
  
  attr_accessor :line_items
  attr_accessor :customer
  attr_accessor :adjustments
  attr_accessor :promotions
  
  def initialize
    self.line_items = {}
    self.adjustments = []
    self.promotions = []
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
  
  def add_adjustment(adjustment)
    self.adjustments << adjustment
  end
  
  def add_adjustments(adjustments)
    self.adjustments = adjustments
  end
  
  def add_promotion(promotion)
    self.promotions << promotion
  end
  
  def total
    total_line_items - total_adjustments
  end
  
  def total_line_items
    self.line_items.keys.inject(0) do |result, key|
      result + line_items[key].subtotal
    end
  end
  
  def total_adjustments
    self.adjustments.inject(0) do |result, adjustment|
      result + adjustment.subtotal
    end
  end
  
  def count_adjustments
    adjustments.length
  end
  
  def count_line_items
    line_items.length
  end
  
  def count_all_line_items
    line_items.keys.inject(0) do |result, key|
      result + line_items[key].quantity
    end
  end
  
end