require 'rails_helper'

RSpec.describe Friendship, type: :model do
  
  it "同じ user と friend の組み合わせは重複できない" do
    user = create(:user)
    friend = create(:user)

    create(:friendship, user: user, friend: friend)
    duplicate = build(:friendship, user: user, friend: friend)

    expect(duplicate).not_to be_valid
  end

  it "初期状態が pending である" do
    friendship = create(:friendship)
    expect(friendship.pending?).to be true
  end
  
  it "accepted に変更できる" do
    friendship = create(:friendship)
    friendship.accepted!
    expect(friendship.accepted?).to be true
  end
end
