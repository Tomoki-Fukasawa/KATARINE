FactoryBot.define do
  factory :friend_ship do
    association :user
    association :friend
  end
end
