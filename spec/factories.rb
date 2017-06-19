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
        default_quantity 2
      end
      
      after(:build) do |order, evaluator|
        evaluator.line_items_count.times do
          item = build(:item)
          evaluator.default_quantity.times do
            order.add_line_item(item)
          end
        end
      end
      
      factory :order_with_line_items_and_adjustments do
        
        transient do
          adjustments_count 2
        end
        
        after(:build) do |order, evaluator|
          order.adjustments = build_list(:adjustment, evaluator.adjustments_count)
        end
      end
      
      factory :order_with_line_items_and_promotions do
        
        transient do
          promotions_count = 2
          
          after(:build) do |order, evaluator|
            order.promotions = build_list(:promotion, evaluator.promotions_count)
          end
        end
      end
      
    end
  end
  
  factory :line_item do
    # association :order, strategy: :build
    
    after(:build) do |line_item, evaluator|
      item = build(:item)
      line_item.item = item
      line_item.price = item.price
    end
  end
  
  factory :promotion do
    
    factory :promotion_with_qualifiers do
      
      transient do
        qualifers_count = 2
      end
      
      after(:build) do |promotion, evaluator|
        promotion.qualifiers = build_list(:qualifier, evaluator.qualifiers_count)
      end
      
    end
    
    
  end
  
end