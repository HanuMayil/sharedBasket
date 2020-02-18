class UserItems < ActiveRecord::Migration[5.2]
  def change
    add_column :user_items, :basket_id, :integer
    remove_column :user_items, :quantity
  end
end
