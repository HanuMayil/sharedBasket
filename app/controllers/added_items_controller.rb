class AddedItemsController < ApplicationController
  def new
    @added_item = AddedItem.new
  end

  def create
    @added_item = AddedItem.new(added_item_params)
    if @added_item.save
      flash[:notice] = "Added item successfully created!"
      redirect_to baskets_path
    else
      flash[:notice] = "Added item  was not created!"
      redirect_to baskets_path
    end
  end

  def destroy
    AddedItem.find(params[:id]).destroy
    flash[:notice] = "Added Item was successfully deleted!"
    redirect_to baskets_path
  end

  private
    def added_item_params
      params.require(:added_item).permit(:id)
    end
end
