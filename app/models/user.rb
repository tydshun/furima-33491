class User < ApplicationRecord
  validates :nickname, presence: true,  length: { maximum: 6 }
  validates :first_name, presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }
  validates :family_name, presence: true, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }
  validates :read_first, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :read_family, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :birth, presence: true
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])[a-z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX },length: { minimum: 6 }

  has_many :items
  has_many :purchases

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
