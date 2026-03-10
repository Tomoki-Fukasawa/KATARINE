FactoryBot.define do
  factory :chat_room do
    association :user1, factory: :user
    association :user2, factory: :user
  end
end
