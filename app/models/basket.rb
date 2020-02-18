class Basket < ActiveRecord::Base
  has_many :basket_members
  has_many :users, :through => :basket_members

  has_many :added_items
  has_many :items, :through => :added_items
end
