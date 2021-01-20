require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテムの保存' do
    context 'アイテムが保存できる場合' do
      it 'image,name,expalanation,category,condition,postage_type,prefecture,preparation_day,priceがあれば商品は保存される' do
        expect(@item).to be_valid
      end
    end
    context 'itemが保存できない場合' do
      it 'imageがないとitemは保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameがないとitemは保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'explanationがないとitemは保存できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'categoryがないとitemは保存できない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'conditionがないとitemは保存できない' do
        @item.condition = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'postage_typeがないとitemは保存できない' do
        @item.postage_type = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage type can't be blank")
      end
      it 'prefectureがないとitemは保存できない' do
        @item.prefecture = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'preparation_dayがないとitemは保存できない' do
        @item.preparation_day = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation day can't be blank")
      end
      it 'categoryが１だとitemは保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'conditionが１だとitemは保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it 'postage_typeが１だとitemは保存できない' do
        @item.postage_type_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage type must be other than 1')
      end
      it 'prefectureが１だとitemは保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'preparation_dayが１だととitemは保存できない' do
        @item.preparation_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Preparation day must be other than 1')
      end
      it 'priceがないとitemは保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが299円以下では出品できない' do
        @item.price = 298
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it 'priceが10_000_000円以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it 'priceが半角英数字混合では出品できない' do
        @item.price = '200a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角英字のみでは出品できない' do
        @item.price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが全角文字では出品できない' do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐付いてないとitemは保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
