class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :name, :explanation, presence: true
  validates :category_id, :condition_id, :postage_type_id, :prefecture_id, :preparation_day_id, numericality: { other_than: 1 }
  
  
  has_one_attached       :image
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_day

  belongs_to :user
  has_one   :purchase
end
