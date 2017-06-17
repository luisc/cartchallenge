class Customer
  
  attr_accessor :order
  attr_accessor :id
  attr_accessor :email
  
  @@customers = []
  
  
  # def initialize(attributes = {})
  #   self.order = attributes[:order] if attributes[:order]
  #   self.email = attributes[:email]
  # end
  
  def self.find(id)
    if @@customers.empty?
      @@customers = InputParser.customers_file(InputParser.data_dir + 'customers')
    end
    
    @@customers[id]
  end
  
end