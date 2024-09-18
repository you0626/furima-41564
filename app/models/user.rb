class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: true,
                      format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must contain @ and be a valid email address' }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must include both letters and numbers' }
    validates :first_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters (kanji, hiragana, katakana)' }
    validates :last_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be full-width characters (kanji, hiragana, katakana)' }
    validates :first_name_katakana, format: { with: /\A[ァ-ヶー]+\z/, message: 'must be full-width katakana characters' }
    validates :last_name_katakana, format: { with: /\A[ァ-ヶー]+\z/, message: 'must be full-width katakana characters' }
    validates :birth
  end

  has_many :prototypes
  has_many :comments
end
