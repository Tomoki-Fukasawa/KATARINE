FactoryBot.define do
  factory :chat_room do
    name {Faker::Team.name}
  end
end
