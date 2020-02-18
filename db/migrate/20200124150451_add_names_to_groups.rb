class AddNamesToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :name, :string
  end
end
