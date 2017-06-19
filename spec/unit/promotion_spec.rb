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
    promotion.add_effect("Some label", BigDecimal("20"))
    promotion.add_effect("Another label", BigDecimal("10"))

    expect(promotion.effects.length).to eq(2)
  end

  it "sets the amount of an effect correctly" do
    item_1 = build(:item)

    promotion = Promotion.new
    promotion.add_effect(item_1, item_1.price)

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
  
  context "processes" do
    
    it "a valid three for one deal" do
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 4)
      item = order.line_items[order.line_items.first.first].item
      
      promotion = Promotion.new
      promotion.add_qualifier(item, 4)
      promotion.add_effect("Buy 3, Get 1 Free", item.price)
      
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq item.price
    end
    
    it "an invalid three for one deal" do
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 3)
      item = order.line_items[order.line_items.first.first].item
      
      promotion = Promotion.new
      promotion.add_qualifier(item, 4)
      promotion.add_effect("Buy 3, Get 1 Free", item.price)
      
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq 0
    end
    
    it "for a valid buy one get another free deal" do
      
      order = build(:order_with_line_items, line_items_count: 2, default_quantity: 1)
      
      promotion = Promotion.new
      item = nil
      order.line_items.keys.each do |key|
        item = order.line_items[key].item
        promotion.add_qualifier(item, 1)
      end
      
      promotion.add_effect("Buy 1, Get Another Free", item.price)
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq item.price
    end
    
    it "for an invalid valid buy one get another free deal" do
      
      order = build(:order_with_line_items, line_items_count: 2, default_quantity: 1)
      
      item_1 = build(:item)
      item_2 = build(:item)
      
      promotion = Promotion.new
      promotion.add_qualifier(item_1, 1)
      promotion.add_qualifier(item_2, 1)
      promotion.add_effect("Buy 1, Get Another Free", item_2.price)
      
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq 0
    end
    
    it "checks for a valid bulk discount" do
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 4)
      line_item = order.line_items[order.line_items.first.first]
      item = line_item.item
      
      promotion = Promotion.new(apply_amount_for_each_match: false)
      promotion.add_qualifier(item, 4)
      total = line_item.quantity * (item.price - 20)
      promotion.add_effect("Buy 4, Get Each $20 off", total)
      
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq total
    end
    
    it "checks for an invalid bulk discount" do
      order = build(:order_with_line_items, line_items_count: 1, default_quantity: 3)
      line_item = order.line_items[order.line_items.first.first]
      item = line_item.item
      
      promotion = Promotion.new(apply_amount_for_each_match: false)
      promotion.add_qualifier(item, 4)
      total = line_item.quantity * (item.price - 20)
      promotion.add_effect("Buy 4, Get Each $20 off", total)
      
      promotion.process_order(order.line_items)
      
      expect(promotion.total).to eq 0
    end
    
  end
  
end