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
  
  it "can have an arbitrary amount of effects" do
    item_1 = build(:item)
    item_2 = build(:item)
    
    promotion = Promotion.new
    promotion.add_effect(item_1, BigDecimal("20"))
    promotion.add_effect(item_2, BigDecimal("10"))
    
    expect(promotion.effects.length).to eq(2)
  end
  
  it "defaults to applying for each match" do
    promotion = Promotion.new
    
    expect(promotion.repeat_application).to eq true
  end
  
  it "can set a flag to apply it for each match" do
    promotion = Promotion.new(repeat_application: false)
    
    expect(promotion.repeat_application).to eq false
  end
  
  context "applies a" do
    
    it "three for one deal" do
      
      item_1 = build(:item)
      
      promotion = Promotion.new
      promotion.add_qualifier(item_1, 3)
      promotion.add_effect("Buy 3, Get 1 Free", item.price)
      
      order = Order.new
      order.add_line_item(item_1)
      order.add_line_item(item_1)
      order.add_line_item(item_1)
      order.add_line_item(item_1)
      
      expect(true).to eq false
    end
    
  end
  
end