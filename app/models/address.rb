class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :city
    validates :address
  end

  belongs_to :order
end
