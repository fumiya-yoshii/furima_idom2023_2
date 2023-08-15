class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }, length: { minimum: 6 }#半角英数字混合

  with_options presence: true do
    validates :nickname
    validates :kanji_last_name,    format: {with: /\A[ぁ-んァ-ン一-龥]/ , message: "is invalid. Input full-width characters."}     #全角かんじ
    validates :kanji_first_name,   format: {with: /\A[ぁ-んァ-ン一-龥]/ , message: "is invalid. Input full-width characters."}     #全角かんじ
    validates :kana_last_name,     format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."} #全角カナ
    validates :kana_first_name,    format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."} #全角カナ
    validates :birthday_yyyy_mm_dd
  end
end