FactoryGirl.define do
  
  factory :item do
    sequence(:name) { |i| "item_#{i}" }
    sequence(:id) { |i| i }
    price BigDecimal("10")
  end
  
  factory :adjustment do
    sequence(:label) { |i| "label_#{i}" }
    amount BigDecimal("5")
    quantity 1
  end
  
  factory :customer do
    sequence(:email) { |i| "example_#{i}@domain.com" }
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
      
      factory :order_with_line_items_and_adjustments do
        
        transient do
          adjustments_count 2
        end
        
        after(:build) do |order, evaluator|
          order.adjustments << { description: 'Something Cool', amount: BigDecimal("5") }
          order.adjustments << { description: 'Adjustment Again', amount: BigDecimal("5") }
        end
      end
    end
  end
  
  factory :line_item do
    association :order, strategy: :build
    
    after(:build) do |line_item, evaluator|
      item = build(:item)
      line_item.item = item
      line_item.price = item.price
    end
  end
  
  factory :promotion do
    association :order, strategy: :build
    sequence(:name) { |i| "promotion_#{i}" }
    amount BigDecimal("5")
  end
  
end