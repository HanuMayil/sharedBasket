class RenameAddedItemIdAndAddBasketIdForUserItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_items, :added_item_id, :item_id
    add_column :user_items, :basket_id, :integer
  end
end
