class CreateUserItems < ActiveRecord::Migration[5.2]
  def change
    create_table :user_items do |t|
      t.belongs_to :item
      t.belongs_to :user
      t.float "percent_owing"
      t.integer "quantity"
      t.timestamps
    end
  end
end
