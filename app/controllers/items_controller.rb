class ItemsController < ApplicationController
  before_action :signin_check, except: [:index]

  def index
  end

  def new

    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new , status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:category_id,:condition_id,:delivery_fee_type_id,:prefecture_id,:shipping_date_id,:price,:image).merge( user_id: current_user.id )
  end

  def signin_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
