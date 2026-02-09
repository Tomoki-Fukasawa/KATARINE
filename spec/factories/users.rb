FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.unique.email }
    password              { Faker::Internet.password(min_length: 6) + '1a' }
    password_confirmation { password }
    last_name_kanji      { '山田' }
    first_name_kanji       { '太郎' }
    last_name_kana       { 'ヤマダ' }
    first_name_kana        { 'タロウ' }
    birth_day             { Date.new(1995, 5, 20) }
    
    after(:build) do |user|
      user.image.attach(
        io: File.open(Rails.root.join('public/images/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end

    trait :system do
      nickname { 'testuser' }
      email    { Faker::Internet.unique.email }
      password { 'password123' }
      password_confirmation { 'password123' }
      birth_day { Date.new(1995, 5, 20) }
    end
  end
end
