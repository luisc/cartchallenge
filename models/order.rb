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
    adjustments.each do |a|
      self.adjustments << a
    end
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
  
  def print_total
    output = header
    output += "\nItems\n"
    self.line_items.keys.each do |key|
      output += "#{line_items[key].quantity} | "
      output += "#{line_items[key].item.name} | "
      output += "#{line_items[key].subtotal}\n"
    end
    
    if adjustments.length > 0
      output += "\nDiscounts\n"
      self.adjustments.each do |adjustment|
        output += "#{adjustment.quantity} | "
        output += "#{adjustment.label} | "
        output += "#{adjustment.subtotal}\n"
      end
      output += "\nTotal Discounts: #{total_adjustments}"
    end
    
    output += "\nOrder Total: #{total}\n"
    
    output
  end
  
  def header
    "Quantity | Item Name | Subtotal\n"
  end
  
end