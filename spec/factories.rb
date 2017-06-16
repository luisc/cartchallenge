FactoryGirl.define do
  
  factory :customer do
    sequence(:email) { |i| "example_#{i}@domain.com" }
  end
  
  factory :order do
    association :customer
  end
  
  factory :order_line_items do
    association :order
  end
  
end