class Item < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :explanation
    validates :caterory_id
    validates :state_id
    validates :spirit_id
    validates :prefecture_id
    validates :day_id
    validates :price
  end

  belongs_to :user
  # has_one :order
end
