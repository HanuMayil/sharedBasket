class AddQuantityToAddedItems < ActiveRecord::Migration[5.2]
  def change
    add_column :added_items, :quantity, :integer
  end
end
