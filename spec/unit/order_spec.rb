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
  
  it "can add promotions one at a time" do
    
    promotion_1 = build(:promotion)
    promotion_2 = build(:promotion)
    
    order = build(:order)
    
    order.add_promotion(promotion_1)
    order.add_promotion(promotion_2)
    
    expect(order.promotions.size).to eq(2)
  end
  
end