class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :telephone_number, :user_id,
                :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                                 length: { minimum: 10, maximum: 11, message: 'is too short' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :token
  end

  def save
    order = Order.new(user_id:, item_id:)

    if order.save
      Address.create(
        postal_code:,
        prefecture_id:,
        municipality:,
        house_number:,
        building_name:,
        telephone_number:,
        order_id: order.id
      )
    else
      order.errors.full_messages.each do |msg|
        errors.add(:base, msg)
      end
      false
    end
  end
end
