FactoryBot.define do
  factory :friendship do
    association :user
    association :friend
    # state {:pending}
  end
end
