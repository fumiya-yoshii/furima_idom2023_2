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

  has_one_attached :image

  # validation
  with_options presence: true do
    validates :image
    validates :name,                  length: { maximum: 40 }
    validates :description,           length: { maximum: 1000 }
    validates :category_id,           numericality: { other_than: 1 ,message:  "を選択してください"}
    validates :condition_id,          numericality: { other_than: 1 ,message: "を選択してください"}
    validates :delivery_fee_type_id,  numericality: { other_than: 1,message: "を選択してください"}
    validates :prefecture_id,         numericality: { other_than: 1,message: "を選択してください" }
    validates :shipping_date_id,      numericality: { other_than: 1,message: "を選択してください" }
    validates :price,                 numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } # 数字のみuser
  end
end
