FactoryBot.define do
  factory :order_address do
    token          {"tok_abcdefghijk00000000000000000"}
    postal_code    {'123-4567'}
    prefecture_id  {2}
    city           {'札幌市'}
    house_num      {'11'}
    phone_num      {'09012345678'}
    item           { association :item }
  end
end
