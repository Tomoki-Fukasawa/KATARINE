# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def create_user(attrs, image_name)
  user = User.find_or_initialize_by(email: attrs[:email])

  user.assign_attributes(attrs)

  if File.exist?(image_path) && !user.image.attached?
    user.image.attach(
      io: File.open(Rails.root.join("db/fixtures/#{image_name}")),
      filename: image_name
    )
  end
  
  user.save!
end
create_user({
  email: "test1@example.com",
  password: "111aaa",
  nickname: "test1",
  first_name_kanji: "一郎",
  last_name_kanji: "佐藤",
  first_name_kana: "イチロウ",
  last_name_kana: "サトウ",
  birth_day: Date.new(1991,1,1)
}, "sample1.jpg")

create_user({
  email: "test2@example.com",
  password: "222bbb",
  nickname: "test2",
  first_name_kanji: "二郎",
  last_name_kanji: "田中",
  first_name_kana: "ジロウ",
  last_name_kana: "タナカ",
  birth_day: Date.new(1992,2,2)
}, "sample2.jpg")

create_user({
  email: "test3@example.com",
  password: "333ccc",
  nickname: "test3",
  first_name_kanji: "三郎",
  last_name_kanji: "鈴木",
  first_name_kana: "サブロウ",
  last_name_kana: "スズキ",
  birth_day: Date.new(1993,3,3)
}, "sample3.jpg")
