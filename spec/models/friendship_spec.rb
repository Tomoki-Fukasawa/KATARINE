require 'rails_helper'

RSpec.describe Friendship, type: :model do
  
  it "同じ user と friend の組み合わせは重複できない" do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: user, friend: friend)
    duplicate = FactoryBot.build(:friendship, user: user, friend: friend)
    expect(duplicate).not_to be_valid
  end

  it "初期状態が pending である" do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship)
    expect(friendship.pending?).to be true
  end
  
  it "accepted に変更できる" do
    user = FactoryBot.create(:user)
    friend = FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: user, friend: friend, state: :pending)
    friendship.update(state: :accepted)
    expect(friendship.accepted?).to be true
  end
end
