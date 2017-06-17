FactoryGirl.define do
  
  factory :item do
    sequence(:name) { |i| "item_#{i}" }
  end
  
  factory :customer do
    sequence(:email) { |i| "example_#{i}@domain.com" }
    # association :order, strategy: :build
  end
  
  factory :order do
    association :customer, strategy: :build
    
    factory :order_with_line_items do
      transient do
        line_items_count 5
      end
      
      after(:build) do |order, evaluator|
        order.line_items = build_list(:line_item, evaluator.line_items_count, order: order, quantity: 2)
      end
    end
  end
  
  factory :line_item do
    association :order, strategy: :build
    sequence(:price) { |i| BigDecimal(i) }
    
    after(:build) do |line_item, evaluator|
      line_item.item = build(:item)
    end
  end
  
end