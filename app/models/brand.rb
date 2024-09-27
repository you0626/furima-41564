class Brand < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Nike' },
    { id: 2, name: 'Adidas' },
    { id: 3, name: 'Puma' },
    { id: 4, name: 'Gucci' },
    { id: 5, name: 'Louis Vuitton' }
    # 他のブランドを追加可能
  ]

  include ActiveHash::Associations
  has_many :items
end
