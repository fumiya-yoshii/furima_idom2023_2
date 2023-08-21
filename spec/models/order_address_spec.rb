require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id, price: @item.price)
    sleep(0.2)
    #"sleep(0.2)"を設定し読み込みタイミングを遅くずらしている。早すぎてactive_hashを読み込む前に処理が進みエラーになるから。
  end

  context '決済可能な場合' do
    it "postal_code,prefecture_id,city,house_num,phone_num,tokenがあれば保存ができること" do
      expect(@order_address).to be_valid
    end
    it "building_nameが空欄でもpostal_code,prefecture_id,city,house_num,phone_num,tokenがあれば保存ができること" do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
    end
  end

  context '決済できない場合' do
    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it "郵便番号が空では保存ができないこと" do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと" do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it " 都道府県のidが１では購入ができないこと" do
      @order_address.prefecture_id = '1'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "市区町村が空では購入ができないこと" do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it "番地が空では購入ができないこと" do
      @order_address.house_num = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("House num can't be blank")
    end
    it "電話番号が空では購入ができないこと" do
      @order_address.phone_num = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num can't be blank")
    end
    it "電話番号は10桁未満では購入ができないこと" do
      @order_address.phone_num = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is too short (minimum is 10 characters)")
    end
    it "電話番号は11桁以上では購入ができないこと" do
      @order_address.phone_num = '123456789012'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is too long (maximum is 11 characters)")
    end
    it "電話番号が全角では購入ができないこと" do
      @order_address.phone_num = '０９０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone num is invalid")
    end
    it "電話番号に半角数字以外が入力されていると購入できないこと" do
       @order_address.phone_num = '0901234aaaa'
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include("Phone num is invalid")
    end
    it 'user_idが紐づいていないと登録できない'do 
       @order_address.user_id = nil
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include("User can't be blank") 
    end
    it 'item_idが紐づいていないと登録できない'do 
       @order_address.item_id = nil
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include("Item can't be blank") 
    end
  end
end