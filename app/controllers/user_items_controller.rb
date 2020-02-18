class UserItemsController < ApplicationController
  def new
    @user_item = UserItem.new
  end

  def create
    @user_item = UserItem.new(user_item_params)
    if @user_item.save
      flash[:notice] = "User item successfully created!"
      redirect_to baskets_path
    else
      flash[:notice] = "User item was not created!"
      redirect_to baskets_path
    end
  end

  def destroy
    @user_item = UserItem.find(params[:id])
    @item = @user_item.item_id
    @basket = Basket.find(@user_item.basket_id)
    @user_item.destroy
    flash[:notice] = "User Item was successfully deleted!"
    @items = UserItem.where(:item_id => @item, :basket_id => @basket.id)
    @items.each do |item|
      item.percent_owing = 100/UserItem.where(:item_id => @item, :basket_id => @basket.id).count
      item.save
    end
      redirect_to baskets_path
  end

  private
    def user_item_params
      params.require(:user_item).permit(:id)
    end
end
