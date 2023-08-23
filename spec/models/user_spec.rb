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
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'emailに@が含まれてない時' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'emailが重複する場合' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordは6文字以上でなければ保存できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'passwordが129桁以上では登録できない' do
        @user.password = 'a' * 130
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは128文字以内で入力してください'
      end
      it 'kanji_last_nameが空では登録できない' do
        @user.kanji_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前を入力してください")
      end
      it 'kanji_last_nameが全角(漢字、カタカナ、ひらがな)でないと登録できない' do
        @user.kanji_last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（漢字）を入力してください')
      end
      it 'kanji_first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.kanji_first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(漢字)を入力してください')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（カナ）を入力してください")
      end
      it 'kana_last_nameが全角(カタカナ)でないと登録できない' do
        @user.kana_last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（カナ）が正しくありません 全角カナを使用してください')
      end
      it 'kana_first_nameが全角（カタカナ）でないと登録できない' do
        @user.kana_first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カナ）が正しくありません 全角カナを使用してください')
      end
      it 'birthday_yyyy_mm_ddが空では登録できない' do
        @user.birthday_yyyy_mm_dd = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'パスワードは半角英字のみでは保存できない' do
        @user.password = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'パスワード全角英数混合では保存できない' do
        @user.password = '１１３３ａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password = '1111111aaaa'
        @user.password_confirmation = '1111111aabb'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
