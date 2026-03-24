FactoryBot.define do
  factory :item do
    item_name              { '品物名' }
    item_script            { '商品です。' }
    category_id { 3 }
    item_state_id { 3 }
    prefecture_id { 3 }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open('public/images/test_image.png'), 
        filename: 'test_image.png', 
        content_type: 'image/png'
      )
    end
  end
end
