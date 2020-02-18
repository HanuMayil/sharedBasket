class AddProperTimestamps < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :group_members, null: false, default: -> { 'NOW()' }
    add_timestamps :basket_members, null: false, default: -> { 'NOW()' }
    add_timestamps :baskets, null: false, default: -> { 'NOW()' }
    add_timestamps :user_items, null: false, default: -> { 'NOW()' }
    add_timestamps :items, null: false, default: -> { 'NOW()' }
  end
end
