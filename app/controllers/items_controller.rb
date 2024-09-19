class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def item_params
    params.require(:item).permit(:title, :explanation, :category_id, :state_id, :spirit_id, :prefecture_id, :day_id, :price,
                                 :image).merge(user_id: current_user.id)
  end
end
