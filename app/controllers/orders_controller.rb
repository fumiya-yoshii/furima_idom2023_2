class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    @order_address.save
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_num, :building_name,:phone_num).merge(item_id: @item.id , user_id: current_user.id)
  end
end
