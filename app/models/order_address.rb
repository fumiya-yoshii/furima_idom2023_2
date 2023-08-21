class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_num, :building_name, :phone_num, :item_id, :user_id, :price, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :house_num
    validates :phone_num, length: { minimum: 10 ,maximum: 11 }, format: { with: /\A[0-9]+\z/ }
    validates :price
  end
 
  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(postal_code: postal_code, prefecture_id: prefecture_id,
                    city: city, house_num: house_num,
                    building_name: building_name, phone_num: phone_num, order_id: order.id)
  end
end