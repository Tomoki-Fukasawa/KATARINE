FactoryBot.define do
  factory :item_request do
    association :item, factory: :item
    association :sender,factory: :user
  end
end
