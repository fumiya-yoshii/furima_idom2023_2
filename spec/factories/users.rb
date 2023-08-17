FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1234abcd' }
    password_confirmation { '1234abcd' }
    kanji_last_name       { 'テスト' }
    kanji_first_name      { '太郎' }
    kana_last_name        { 'テスト' }
    kana_first_name       { 'タロウ' }
    birthday_yyyy_mm_dd   { '1996-05-10' }
  end
end
