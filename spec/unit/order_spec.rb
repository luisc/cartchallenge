require 'spec_helper'

RSpec.describe Order do
  
  it "sums the prices of its line items" do
    order = build(:order_with_line_items)
    
    expect(order.total_line_items).to eq(BigDecimal.new('100'))
  end
  
  it "counts the different line items" do
    order = build(:order_with_line_items, line_items_count: 2)
    
    expect(order.count_line_items).to eq(2)
  end
  
  it "counts the all of the items" do
    order = build(:order_with_line_items)
    
    expect(order.count_all_line_items).to eq(10)
  end
  
  it "counts the different promotions" do
    order = build(:order_with_line_items_and_adjustments)
    
    expect(order.count_adjustments).to eq(2)
  end
  
  it "sums the prices of its promotions" do
    order = build(:order_with_line_items_and_adjustments)
    
    expect(order.total_adjustments).to eq(BigDecimal.new('10'))
  end
  
  it "gets the difference between its line items and promotions" do
    order = build(:order_with_line_items_and_adjustments)
    
    expect(order.total).to eq(BigDecimal.new('90'))
  end
  
end