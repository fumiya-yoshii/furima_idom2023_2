class ItemsController < ApplicationController
  before_action :signin_check, except: [:index, :show]
  before_action :set_item, only: [:show,:edit, :update ,:destroy]

  def index

    @items = Item.all.order(id: 'DESC')

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
  end

  def edit
    if current_user != @item.user || Order.exists?(item_id: @item.id) 
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path #詳細画面完成後にパスを変更する
    else
      render :edit, status: :unprocessable_entity
    
    end
  end

  def show
  end

  def destroy
    if @item.user == current_user
      @item.delete
    end
    redirect_to root_path
  end
  


  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_fee_type_id, :prefecture_id,
                                 :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def signin_check
    return if user_signed_in?
    redirect_to new_user_session_path
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
