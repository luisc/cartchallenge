class Item
  
  attr_accessor :id
  attr_accessor :name
  attr_accessor :price
  
  @@items = {}
  
  def self.find(id)
    if @@items.empty?
      @@items = InputParser.items_file(InputParser.data_dir + 'items')
    end
    
    @@items[id]
  end
  
end