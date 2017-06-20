require 'spec_helper'

RSpec.describe InputParser do
  
  it "successfully reads the customers file" do
    customers = InputParser.customers_file(InputParser.data_dir + 'customers')
    
    expect(customers).not_to be_nil
  end
  
  it "successfully reads the items file" do
    items = InputParser.items_file(InputParser.data_dir + 'items')
    
    expect(items).not_to be_nil
  end
  
  it "successfully reads the orders file" do
    orders = InputParser.orders_file(InputParser.data_dir + 'orders')
    
    expect(orders).not_to be_nil
  end
  
end