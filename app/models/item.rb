class Item < ApplicationRecord
  # Association
  belongs_to :user
  # has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee_type
  belongs_to :prefecture
  belongs_to :shipping_date

  has_many_attached :images

  # validation
  with_options presence: true do
    validates :images,                length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
    validates :name,                  length: { maximum: 40 }
    validates :description,           length: { maximum: 1000 }
    validates :category_id,           numericality: { other_than: 1 }
    validates :condition_id,          numericality: { other_than: 1 }
    validates :delivery_fee_type_id,  numericality: { other_than: 1 }
    validates :prefecture_id,         numericality: { other_than: 1 }
    validates :shipping_date_id,      numericality: { other_than: 1 }
    validates :price,                 numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } # 数字のみuser
  end
end
