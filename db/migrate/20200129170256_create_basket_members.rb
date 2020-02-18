class CreateBasketMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :basket_members do |t|
      t.belongs_to :user
      t.belongs_to :basket
    end
  end
end
