class AddNamesToBaskets < ActiveRecord::Migration[5.2]
  def change
    add_column :baskets, :name, :string
  end
end
