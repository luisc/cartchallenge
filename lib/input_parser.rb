class InputParser
    
  class << self
    
    def orders_file(file)
      orders = []
      
      File.open(file).each do |line|
        order = Order.new
        elements = line.chomp.split("\t")
        order.customer = Customer.find(elements.first.to_i)
        elements[1..-1].each do |e|
          order.add_line_item(Item.find(e))
        end
        
        orders << order
      end
      
      orders
    end
    
    def customers_file(file)
      customers = []
      
      File.open(file).each do |line|
        customer = Customer.new
        elements = line.chomp.split("\t")
        
        customer.id = elements.first.to_i
        customer.email = elements.last
        
        customers[customer.id] = customer
      end
      
      customers
    end
    
    def items_file(file)
      items = {}
      
      File.open(file).each do |line|
        item = Item.new
        elements = line.chomp.split("\t")
        
        item.id = elements.first
        item.name = elements[1]
        item.price = BigDecimal(elements[2].sub('$', ''))
        
        items[item.id] = item
      end
      
      items
    end
    
    def data_dir
      File.dirname(__FILE__) + '/../data/input/'
    end
    
  end

end