class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :name
    validates :explanation
    validates :image
    validates :price, numericality: { only_integer: true }
    with_options numericality: { other_than: 1, only_integer: true } do
      validates :category_id
      validates :condition_id
      validates :postage_type_id
      validates :prefecture_id
      validates :preparation_day_id
    end
  end
  validates_inclusion_of :price, in: 300..9_999_999

  has_one_attached       :image
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_day

  belongs_to :user
  has_one :purchase
end
