FactoryBot.define do
  factory :item do
    name                 { 'テスト' }
    description          { 'テスト用の説明です' }
    category_id          { 2 }
    condition_id         { 2 }
    delivery_fee_type_id { 2 }
    prefecture_id        { 2 }
    shipping_date_id     { 2 }
    price                { 10_000 }
    user                 { association :user }

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
