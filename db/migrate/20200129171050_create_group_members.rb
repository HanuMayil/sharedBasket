class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.belongs_to :user
      t.belongs_to :group
    end
  end
end
