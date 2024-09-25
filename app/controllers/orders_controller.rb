class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
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
                                          :telephone_number, :user_id, :item_id)
  end
end
