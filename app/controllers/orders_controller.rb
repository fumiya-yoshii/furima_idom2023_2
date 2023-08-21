class OrdersController < ApplicationController
  before_action -> {
    sold_item
    set_token
  } 

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_order
      @order_address.save
    return redirect_to root_path
    else
      render :index , status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_num, :building_name,:phone_num,:price).merge(token:params[:token],item_id: @item.id , user_id: current_user.id, price: @item.price)
  end

  def pay_order
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPテスト秘密鍵
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end

  def sold_item
    @item = Item.find(params[:item_id])
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif Order.exists?(item_id: @item.id) || @item.user == current_user
      redirect_to root_path
    end
  end

  def set_token
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end
