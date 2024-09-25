class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      Payjp.api_key = 'sk_test_0a9108245e41d108c35c16e9'
      Payjp::Charge.create(
        amount: @item.price,
        card: @order_address.token,
        currency: 'jpy'
      )
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                                          :telephone_number, :user_id, :item_id).merge(token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
