class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :title, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :state_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :spirit_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :day_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :price
  end

  belongs_to :user
  # has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :spirit
  belongs_to :prefacture
  belongs_to :day
end
