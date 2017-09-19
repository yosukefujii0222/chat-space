require 'rails_helper'
describe Message do
#メッセージ、画像、グループID、ユーザーIDがあれば保存
  describe "#create" do
    it "is valid with a body, image, group_id, user_id" do
      message = build(:message)
      message.valid?
      expect(message).to be_valid
    end
  end
#メッセージがなくても(画像があれば)保存
  describe "#create" do
    it "is valid without a body" do
      message = build(:message, body: nil)
      message.valid?
      expect(message).to be_valid
    end
  end
#画像がなくても(メッセージがあれば)保存
  describe "#create" do
    it "is valid without a image" do
      message = build(:message, image: nil)
      message.valid?
      expect(message).to be_valid
    end
  end
#メッセージも画像もないと保存できない
  describe "#create" do
    it "is invalid without a body or image" do
      message = build(:message, body:nil, image:nil)
      message.valid?
      expect(message.errors[:body_or_image]).to include("を入力してください")
    end
  end
#group_idがないと保存できない
  describe "#create" do
    it "is invalid without group_id" do
      message = build(:message, group_id: nil)
      message.valid?
      expect(message.errors[:group]).to include("を入力してください")
    end
  end
#user_idがないと保存できない
  describe "#create" do
    it "is invalid without user_id" do
      message = build(:message, user_id: nil)
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end
  end
end
