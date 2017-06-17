require 'spec_helper'

RSpec.describe Order do
  
  it "sums the prices of its line items" do
    order = build(:order_with_line_items)
    
    expect(order.total).to eq(BigDecimal.new('30'))
  end
  
  it "counts the different line items" do
    order = build(:order_with_line_items, line_items_count: 3)
    
    expect(order.count_line_items).to eq(3)
  end
  
  it "counts the all of the items" do
    order = build(:order_with_line_items)
    
    expect(order.count_all_line_items).to eq(10)
  end
  
end