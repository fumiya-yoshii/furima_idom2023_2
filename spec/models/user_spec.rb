require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname,email,password,kanji_last_name,kanji_first_name,kana_last_name,kana_first_name,birthday_yyyy_mm_ddか存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに@が含まれてない時' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'emailが重複する場合' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上でなければ保存できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'passwordが129桁以上では登録できない' do
        @user.password = 'a' * 130
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
      end
      it 'kanji_last_nameが空では登録できない' do
        @user.kanji_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last name can't be blank")
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name can't be blank")
      end
      it 'kanji_last_nameが全角(漢字、カタカナ、ひらがな)でないと登録できない' do
        @user.kanji_last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji last name is invalid. Input full-width characters.')
      end
      it 'kanji_first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.kanji_first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji first name is invalid. Input full-width characters.')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'kana_last_nameが全角(カタカナ)でないと登録できない' do
        @user.kana_last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name is invalid. Input full-width katakana characters.')
      end
      it 'kana_first_nameが全角（カタカナ）でないと登録できない' do
        @user.kana_first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name is invalid. Input full-width katakana characters.')
      end
      it 'birthday_yyyy_mm_ddが空では登録できない' do
        @user.birthday_yyyy_mm_dd = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday yyyy mm dd can't be blank")
      end
      it 'パスワードは半角英字のみでは保存できない' do
        @user.password = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワード全角英数混合では保存できない' do
        @user.password = '１１３３ａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password = '1111111aaaa'
        @user.password_confirmation = '1111111aabb'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
