class Item < ActiveRecord::Base
  has_many :added_items
  has_many :baskets, :through => :added_items

  has_many :user_items
  has_many :users, :through => :user_items
end
