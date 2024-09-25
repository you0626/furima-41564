class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0, message: }
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  end

  belongs_to :order
end
