class User < ApplicationRecord
  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ } 
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ } 
    validates :birth
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :read_first
    validates :read_family
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }, length: { minimum: 6 }
  
  chas_many :items
  has_many :purchases

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
