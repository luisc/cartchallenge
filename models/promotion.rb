class Promotion
  
  attr_accessor :qualifiers
  attr_accessor :effects
  attr_accessor :apply_amount_for_each_match
  attr_accessor :results
  
  def initialize(attrs = {})
    self.qualifiers = {}
    self.effects = []
    self.results = []
    self.apply_amount_for_each_match = attrs[:apply_amount_for_each_match].nil? ? true : attrs[:apply_amount_for_each_match]
  end
  
  def add_qualifier(item, quantity)
    self.qualifiers[item] = quantity
  end
  
  def add_effect(label, amount)
    effect = { label: label }
    effect[:amount] = amount
    
    self.effects << effect
  end
  
  def process_order(line_items)
    found = true
    matches = []
    self.results = []
    
    self.qualifiers.keys.each do |item|
      li = line_items[item.id]
      
      if found && li && li.quantity >= self.qualifiers[item]
        found = true
        matches << (self.apply_amount_for_each_match ? li.quantity / self.qualifiers[item] : 1)
      else
        found = false
      end
      
    end
    
    if found
      min = matches.min
      self.effects.each do |effect|
        self.results << Adjustment.new(label: effect[:label], amount: effect[:amount], quantity: min)
      end
    end
    
    results
  end
  
  def total
    self.results.inject(0) do |total, adjustment|
      total + (adjustment.amount * adjustment.quantity)
    end
  end
  
end