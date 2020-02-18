class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.integer "owner_id"
      t.float "total_price"
    end
  end
end
