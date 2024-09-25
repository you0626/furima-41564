class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :telephone_number, :user_id,
                :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
    validates :prefecture_id, numericality: { other_than: 0 }
  end

  def save
    order = Order.create(user_id:, item_id:)
    Address.create(postal_code:, prefecture_id:, municipality:,
                   house_number:, building_name:, telephone_number:, order_id: order.id)
  end
end
