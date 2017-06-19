class Promotion
  
  attr_accessor :qualifiers
  attr_accessor :effects
  attr_accessor :apply_amount_for_each_match
  
  def initialize(attrs = {})
    self.qualifiers = {}
    self.effects = []
    self.apply_amount_for_each_match = attrs[:apply_amount_for_each_match].nil? ? true : attrs[:apply_amount_for_each_match]
  end
  
  def add_qualifier(item, quantity)
    self.qualifiers[item] = quantity
  end
  
  def add_effect(label, &amount)
    effect = { label: label }
    effect[:amount] = yield if block_given?
    
    self.effects << effect
  end
  
  def results(line_items)
    index = {}
    
    # if qualifies?(line_items)
    #
    # end
    
  end
  
  def qualifies?(line_items)
    
    found = true
    
    self.qualifiers.keys.each do |item|
      li = line_items[item.id]
      found = (found && li && li.quantity >= self.qualifiers[item]) ? true : false
    end
    
    found
    
  end
  
end