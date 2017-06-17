require 'spec_helper'

RSpec.describe Promotion do
  
  it "can have an arbitrary amount of qualifiers" do
    item_1 = build(:item)
    item_2 = build(:item)
    
    promotion = Promotion.new
    promotion.add_qualifier(item_1, 2)
    promotion.add_qualifier(item_2, 1)
    
    expect(promotion.qualifiers.length).to eq(2)
  end
  
  it "can add line items" do
    order = build(:order_with_line_items)
    
    promotion = Promotion.new
    promotion.add_line_items(order.line_items)
    
    expect(order.line_items.length).to be > 0
  end
  
  it "can add one adjustment at a time" do
    
    adjustment_1 = build(:adjustment)
    adjustment_2 = build(:adjustment)
    
    order = build(:order)
    order.add_adjustment(adjustment_1)
    order.add_adjustment(adjustment_2)
    
    expect(order.adjustments.size).to eq(2)
    
  end
  
  it "can add an array of adjustments" do
    adjustments = [build(:adjustment), build(:adjustment)]
    order = build(:order)
    
    order.add_adjustments(adjustments)
    
    expect(order.adjustments.size).to eq(adjustments.size)
  end
  
end