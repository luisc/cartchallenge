require 'spec_helper'

RSpec.describe "CustomerCheckout" do
  
  context "checks adding" do
    
    it "an item to an order" do
      order = build(:order)
      item = build(:item)
    
      order.add_line_item(item)
    
      expect(order.line_items[item.id].item).to eq(item)
    end
    
    it "a duplicate item increments line item quantity" do
      order = build(:order)
      item = build(:item)
    
      (repetitions = 3).times do
        order.add_line_item(item)
      end
    
      expect(order.line_items[item.id].quantity).to eq(repetitions)
    end
  
    it "a different item increments the line item count" do
      order = build(:order)
      item1 = build(:item)
      item2 = build(:item)

      order.add_line_item(item1)
      order.add_line_item(item2)

      expect(order.line_items.size).to eq(2)
    end
    
  end
  
  
  
  
  # it "applies promotion" do
  #   expect(true).to eq(false)
  # end
end