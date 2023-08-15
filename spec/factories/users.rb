FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    kanji_last_name       {'テスト'}
    kanji_first_name      {'太郎'}
    kana_last_name        {'テスト'}
    kana_first_name       {'タロウ'}
    birthday_yyyy_mm_dd   {'1996-05-10'}
  end
end
