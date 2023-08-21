require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '決済可能な場合' do
    it "priceとtokenがあれば保存ができること" do
      expect(@order).to be_valid
    end
  end

  context '決済できない場合' do
    it "tokenが空では登録できないこと" do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
    it "priceが空では保存ができないこと" do
      @order.price = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Price can't be blank")
    end
  end
end