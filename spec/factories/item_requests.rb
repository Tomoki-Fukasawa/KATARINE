FactoryBot.define do
  factory :item_request do
    association :item
    association :sender,factory: :user
  end
end
