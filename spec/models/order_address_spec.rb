require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品の購入' do
    context '商品が購入できる場合' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end

      it 'building_nameが空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:token]).to include("can't be blank")
      end

      it '郵便番号が空では購入できない' do
        @order_address.postal_code = ''
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の形式であること' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid

        @order_address.postal_code = '1234567'
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:postal_code]).to include('is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が空では購入できない' do
        @order_address.prefecture_id = nil
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it '都道府県のIDが0以外であること' do
        @order_address.prefecture_id = 0
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it '市区町村が空では購入できない' do
        @order_address.municipality = ''
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:municipality]).to include("can't be blank")
      end

      it '番地が空では購入できない' do
        @order_address.house_number = ''
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:house_number]).to include("can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_address.telephone_number = ''
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:telephone_number]).to include("can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @order_address.telephone_number = '123456789'
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:telephone_number]).to include('is invalid. Input only number')
      end

      it '電話番号が12桁以上では購入できない' do
        @order_address.telephone_number = '123456789012'
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:telephone_number]).to include('is invalid. Input only number')
      end

      it '電話番号に英数字以外が含まれている場合は購入できない' do
        @order_address.telephone_number = '090-1234-5678'
        expect(@order_address).to be_invalid
        expect(@order_address.errors[:telephone_number]).to include('is invalid. Input only number')
      end

      it 'userが紐づいていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors[:user_id]).to include("can't be blank")
      end

      it 'itemが紐づいていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors[:item_id]).to include("can't be blank")
      end
    end
  end
end
