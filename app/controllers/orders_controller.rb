class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = Address.new
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                                          :telephone_number, :user_id, :item_id)
  end
end
