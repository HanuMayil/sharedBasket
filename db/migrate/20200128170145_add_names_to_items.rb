class AddNamesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :name, :string
  end
end
