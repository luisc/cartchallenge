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
  
end