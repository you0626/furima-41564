class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user)
  end

  def new
    @pitem = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :explanation, :category_id, :state_id, :spirit_id, :prefecture_id, :day_id, :price,
                                 :image).merge(user_id: current_user.id)
  end
end
