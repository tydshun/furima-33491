class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :postage_type_id, :prefecture_id, :preparation_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
