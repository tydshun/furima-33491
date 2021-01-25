require 'rails_helper'

RSpec.describe PurchaseShopping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shopping = FactoryBot.build(:purchase_shopping, user_id: user.id, item_id: item.id)
    sleep(1)
  end

  context "購入成功時" do
    it "カード情報(token)、配送先の入力が正しく入力されていれば購入ができること" do
      expect(@purchase_shopping).to be_valid
    end

    it "建物名が空でも登録できること" do
      @purchase_shopping.building_name = nil
      expect(@purchase_shopping).to be_valid
    end
  end

  context "エラー発生時" do
    it "tokenが空では購入できないこと" do
      @purchase_shopping.token = nil
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Token can't be blank")
    end

    it "郵便番号が入力されていなければ購入できないこと" do
      @purchase_shopping.postal_code = nil
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code can't be blank")
    end

    it "郵便番号は7文字でないと購入できないこと" do
      @purchase_shopping.postal_code = "123-456"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
    end

    it "郵便番号はハイフン(-)ないと購入できないこと" do
      @purchase_shopping.postal_code = "1234567"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
    end

    it "郵便番号は半角数字でないと購入できないこと" do
      @purchase_shopping.postal_code = "１２３-４５６７"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
    end

    it "都道府県のid番号1(---)だと購入できないこと" do
      @purchase_shopping.prefecture_id = 1
      @purchase_shopping.valid?

      expect(@purchase_shopping.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it "市区町村がなければ購入できないこと" do
      @purchase_shopping.city = nil
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("City can't be blank")
    end

    it "市区町村にひらがな、漢字以外が入っていると購入できないこと" do
      @purchase_shopping.city = "yokohamasimidoriku"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("City is invalid")
    end

    it "番地がなければ購入できないこと" do
      @purchase_shopping.address = nil
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Address can't be blank")
    end

    it "電話番号がないと購入できないこと" do
      @purchase_shopping.phone_number = nil
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号に文字が入ると購入できないこと" do
      @purchase_shopping.phone_number = '0901234567a'
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号が全角数字だと購入できないこと" do
      @purchase_shopping.phone_number = '０９０１２３４５６７８'
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号はハイフン(-)が入っていると購入できないこと" do
      @purchase_shopping.phone_number = "090-1234-5678"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号は９桁以下だと購入できないこと" do
      @purchase_shopping.phone_number = "090123456"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号は12桁以上だと購入出来ない" do
      @purchase_shopping.phone_number = "090123456789"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
    end
  end
end
