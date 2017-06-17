require 'spec_helper'

RSpec.describe Order do
  it "sums the prices of its line items" do
    order = Order.new

    order.add_line_item(
      LineItem.new(
        :item => Item.new(:price => BigDecimal.new('1.11'))
      ))
    order.add_line_item(
      LineItem.new(
        :item => Item.new(:price => BigDecimal.new('2.22')),
        :quantity => 2
      ))
    
    expect(order.total).to eq(BigDecimal.new('5.55'))
  end
end