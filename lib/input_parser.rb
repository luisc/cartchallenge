class InputParser
    
  class << self
    
    def orders_file(file)
      orders = []
      
      File.open(file).each do |line|
        order = Order.new
        elements = line.chomp.split("\t")
        order.customer = Customer.find(elements.first.to_i)
        order.line_items = elements[1..-1]
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
    
    def data_dir
      File.dirname(__FILE__) + '/../data/input/'
    end
    
  end

end