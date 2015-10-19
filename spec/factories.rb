FactoryGirl.define do
  factory :shipment do
    shipping_label ""
  end

  factory :address do
    association :shipment
  end
end