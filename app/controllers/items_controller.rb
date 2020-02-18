class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item successfully created!"
      render :edit
    else
      flash[:notice] = "Item was not created!"
      redirect_to :back
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Basket was successfully updated!"
      render :edit
    else
      render
    end
  end

  def show_basket
    @baskets = Basket.all
    @item = Item.find(params[:item])
    render :baskets
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:notice] = "Item was successfully deleted!"
    redirect_to baskets_path
  end

  private
    def item_params
      params.require(:item).permit(:id)
    end
  end
