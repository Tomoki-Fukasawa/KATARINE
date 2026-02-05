FactoryBot.define do
  factory :board do
    title {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    association :user 
  end
end
