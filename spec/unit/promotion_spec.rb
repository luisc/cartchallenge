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
    promotion.add_effect("Some label") { BigDecimal("20") }
    promotion.add_effect("Another label") { BigDecimal("10") }

    expect(promotion.effects.length).to eq(2)
  end

  it "sets the amount of an effect correctly" do
    item_1 = build(:item)

    promotion = Promotion.new
    promotion.add_effect(item_1) { item_1.price }

    expect(promotion.effects.first[:amount]).to eq item_1.price
  end

  it "defaults to applying for each match" do
    promotion = Promotion.new

    expect(promotion.apply_amount_for_each_match).to eq true
  end

  it "can set a flag to apply it for each match" do
    promotion = Promotion.new(apply_amount_for_each_match: false)

    expect(promotion.apply_amount_for_each_match).to eq false
  end
  
  context "checks qualifiers" do
    
    it "for a valid three for one deal" do
      
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 4)
      item = order.line_items[order.line_items.first.first].item
      
      promotion = Promotion.new
      promotion.add_qualifier(item, 4)
      promotion.add_effect("Buy 3, Get 1 Free") { item.price }
      
      expect(promotion.qualifies?(order.line_items)).to eq true
    end
    
    it "for an invalid three for one deal" do
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 3)
      item = order.line_items[order.line_items.first.first].item
      
      promotion = Promotion.new
      promotion.add_qualifier(item, 4)
      promotion.add_effect("Buy 3, Get 1 Free") { item.price }
      
      expect(promotion.qualifies?(order.line_items)).to eq false
    end
    
    
  end
  
  context "applies a" do
    
    it "three for one deal" do
      
      # expect(true).to eq false
    end
    
  end
  
end