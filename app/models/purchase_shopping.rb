class PurchaseShopping

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token, :user_id, :item_id
  
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1, only_integer: true }
    validates :city, format: {with: /\A[ぁ-んァ-ン一-龥々]/}
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :token
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    # 各テーブルにデータを保存する処理を書いていく
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shopping.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end