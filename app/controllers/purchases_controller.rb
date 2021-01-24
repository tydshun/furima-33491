class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  def index
    @purchase_shopping = PurchaseShopping.new
    @item = Item.find(params[:item_id])
    if @item.purchase != nil || current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def create
    @purchase_shopping = PurchaseShopping.new(purchase_shopping_params)
    @item = Item.find(params[:item_id])
    if @purchase_shopping.valid?
      pay_item
      @purchase_shopping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private 
  def purchase_shopping_params
    params.require(:purchase_shopping).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number,:token).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_shopping_params[:token],
      currency:'jpy'
    )
  end
end
