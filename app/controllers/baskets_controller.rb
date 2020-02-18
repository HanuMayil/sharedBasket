class BasketsController < ApplicationController
  def index
    @baskets = Basket.all
  end

  def show
    @basket = Basket.find(params[:id])
  end

  def new
    @basket = Basket.new
  end

  def create
    @basket = Basket.new(basket_params)
    @basket.total_price = 0
    @basket.owner_id = current_user.id
    @basket.users << current_user
    @basket.save
    if @basket.save
      flash[:notice] = "Basket successfully created!"
      render :edit
    else
      flash[:notice] = "Basket was not created!"
      redirect_to :back
    end
  end

  def edit
    @basket = Basket.find(params[:id])
  end

  def update
    @basket = Basket.find(params[:id])
    if @basket.update(basket_params)
      flash[:notice] = "Basket was successfully updated!"
      render :edit
    else
      render
    end
  end

  def add_shopper
    @basket = Basket.find(params[:basket])
    @user = User.find(params[:user])
    @items = @basket.items

    @basket.users << @user unless @basket.users.exists? @user.id
    flash[:notice] = "User was successfully added!"
    @basket.save

    @items.uniq.each do |item|
      @user_item = UserItem.create
      @user_item.user_id = @user.id
      @user_item.item_id = item.id
      @user_item.basket_id = @basket.id
      @user_item.save
      @user_item.percent_owing = 100 / UserItem.where(:item_id => item.id, :basket_id => @basket.id).count
      @user_item.save
      UserItem.where(:item_id => item.id, :basket_id => @basket.id).each do |it|
        it.percent_owing = 100 / UserItem.where(:item_id => item.id, :basket_id => @basket.id).count
        it.save
      end
    end

    render :edit
  end

  def add_item
    @basket = Basket.find(params[:basket])
    @item = Item.find(params[:item])
    @items = Item.all
    @users = @basket.users

    @added_item = AddedItem.create
    @added_item.item_id = @item.id
    @added_item.user_id = current_user.id
    @added_item.basket_id = @basket.id
    @added_item.quantity = 1.0
    @added_item.save

    @users.each do |user|
      if UserItem.where(:user_id => user.id, :item_id => @item.id, :basket_id => @basket.id).exists?
        @change = UserItem.where(:user_id => user.id, :item_id => @item.id, :basket_id => @basket.id)
        @change.each do |change|
          change.percent_owing = 100 / UserItem.where(:item_id => @item.id, :basket_id => @basket.id).count
          change.save
        end
      end

      if UserItem.where(:user_id => current_user.id, :item_id => @item.id, :basket_id => @basket.id).exists?
      else
        @user_item = UserItem.create
        @user_item.user_id = current_user.id
        @user_item.item_id = @item.id
        @user_item.basket_id = @basket.id
        @user_item.save
        @user_item.percent_owing = 100 / UserItem.where(:item_id => @item.id, :basket_id => @basket.id).count
        @user_item.save
      end
    end

    subtotal = 0
    @items.each do |item|
      subtotal += item.unit_price * AddedItem.where(:item_id => item.id, :basket_id => @basket.id).count
    end

    @basket.total_price = subtotal
    flash[:notice] = "Item was successfully added!"
    @basket.save
    render :edit
  end

  def remove_item
    @basket = Basket.find(params[:basket])
    @item = Item.find(params[:item])
    @items = Item.all

    @added_item = AddedItem.where(:item_id => @item.id, :basket_id => @basket.id)
    @added_item.first.destroy
    subtotal = 0

    if AddedItem.where(:item_id => @item.id, :basket_id => @basket.id).count == 0
      @delete = UserItem.where(:item_id => @item.id, :basket_id => @basket.id)
      @delete.each do |delete|
        delete.destroy
      end
    end

    @items.each do |item|
      subtotal += item.unit_price * AddedItem.where(:item_id => item.id, :basket_id => @basket.id).count
    end

    @basket.total_price = subtotal
    flash[:notice] = "Item was successfully removed!"
    @basket.save
    render :edit
  end

  def destroy
    @basket = Basket.find(params[:id])
    @basket.items.delete_all

    @user_item = UserItem.where(:basket_id => @basket.id)
    @user_item.each do |user_item|
      user_item.destroy
    end

    Basket.find(params[:id]).destroy
    flash[:notice] = "Basket was successfully deleted!"
    redirect_to baskets_path
  end

  def remove_shopper
    @basket = Basket.find(params[:basket])
    @user = User.find(params[:user])
    @items = Item.all

    @user_item = UserItem.where(:user_id => @user.id, :basket_id => @basket.id)
    @user_item.each do |user_item|
      user_item.destroy
    end

    @basket.users.delete(@user)

    @items.each do |item|
      UserItem.where(:item_id => item.id, :basket_id => @basket.id).each do |change|
        change.percent_owing = 100 / UserItem.where(:item_id => item.id, :basket_id => @basket.id).count
        change.save
      end
    end

    flash[:notice] = "User was successfully removed!"
    render :edit
  end

  def show_user
    @basket = Basket.find(params[:basket])
    @item = Item.find(params[:item])
    render :share
  end

  def share
    @basket = Basket.find(params[:basket])
    @item = Item.find(params[:item])
    @user = User.find(params[:user])
    @users = @basket.users

    @user_item = UserItem.create
    @user_item.user_id = @user.id
    @user_item.item_id = @item.id
    @user_item.basket_id = @basket.id
    @user_item.save
    @user_item.percent_owing = 100 / UserItem.where(:item_id => @item.id, :basket_id => @basket.id).count
    @user_item.save

    @users.each do |user|
      if UserItem.where(:user_id => user.id, :item_id => @item.id, :basket_id => @basket.id).exists?
        @change = UserItem.where(:user_id => user.id, :item_id => @item.id, :basket_id => @basket.id)
        @change.each do |change|
          change.percent_owing = 100 / UserItem.where(:item_id => @item.id, :basket_id => @basket.id).count
          change.save
        end
      end
    end

    render :edit
  end

  private
    def basket_params
      params.require(:basket).permit(:name)
    end
  end
