class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_params, only: [:show, :edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
  end

  def edit
    if current_user.id != @item.user.id
    else
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  private

  def find_params
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :postage_type_id, :prefecture_id,
                                 :preparation_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
