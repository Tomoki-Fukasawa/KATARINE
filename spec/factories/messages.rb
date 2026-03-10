FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :chat_room

    # after(:build) do |message|
    #   message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    # end
    trait :with_image do
      after(:build) do |message|
        message.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
