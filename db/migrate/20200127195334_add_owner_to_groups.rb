class AddOwnerToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :owned_by_user_id, :integer
  end
end
