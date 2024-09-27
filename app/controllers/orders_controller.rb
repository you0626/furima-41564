class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :move_to_root_if_sold
  before_action :move_to_root_if_seller

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @item.sold_out?
      redirect_to root_path, alert: 'This item is already sold out.'
    elsif @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :new
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                                          :telephone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @order_address.token,
      currency: 'jpy'
    )
  end

  def move_to_root_if_sold
    return unless @item.sold_out?

    redirect_to root_path
  end

  def move_to_root_if_seller
    return unless @item.user == current_user

    redirect_to root_path
  end
end
