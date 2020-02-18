class AddReferredByUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :referred_by_user_id, :integer
  end
end
