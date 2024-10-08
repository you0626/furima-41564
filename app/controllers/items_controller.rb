class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_item_owner, only: [:edit, :update, :destroy]
  before_action :move_to_index_if_sold, only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
    @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
    @items = @items.where(brand_id: params[:brand_id]) if params[:brand_id].present?
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @previous_item = Item.where('id < ?', @item.id).order(id: :desc).first
    @next_item = Item.where('id > ?', @item.id).order(id: :asc).first
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  def search
    keyword = params[:keyword]
    @items = if keyword.present?
               Item.where('title LIKE ?', "%#{keyword}%")
             else
               Item.none
             end
  end

  private

  def item_params
    params.require(:item).permit(:title, :explanation, :category_id, :state_id, :spirit_id, :prefecture_id, :day_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_item_owner
    return if @item.user == current_user

    redirect_to root_path
  end

  def move_to_index_if_sold
    return unless @item.sold_out?

    redirect_to root_path
  end
end
