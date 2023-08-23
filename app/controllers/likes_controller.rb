class LikesController < ApplicationController
  before_action :set_item_like
  before_action :authenticate_user!   # ログイン中のユーザーのみに許可

  def create
    if @item.user_id != current_user.id
      @item_like = current_user.likes.build(item_id: params[:item_id])#Like.new(user_id: current_user.id, item_id: params[:item_id])
      @item_like.save
      respond_to do |format|
        format.js
      end
    end
  end  

  def destroy
    if @item.user_id != current_user.id
      @item_like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
      @item_like.delete
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_item_like
    @item = Item.find(params[:item_id])
  end

end
