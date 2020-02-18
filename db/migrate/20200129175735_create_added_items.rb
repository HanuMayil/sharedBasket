class CreateAddedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :added_items do |t|
      t.belongs_to :item
      t.belongs_to :basket
      t.belongs_to :user
    end
  end
end
