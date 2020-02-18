class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
        t.float "unit_price"
    end
  end
end
