class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                                 length: { minimum: 10, maximum: 11, message: 'is too short' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  belongs_to :order
end
