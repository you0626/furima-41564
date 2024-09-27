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
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  belongs_to :user
  has_one_attached :image
  has_one :order
  def sold_out?
    order.present?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :spirit
  belongs_to :prefecture
  belongs_to :day
  belongs_to :brand
end
