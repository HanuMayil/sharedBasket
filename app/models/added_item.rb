class AddedItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :item
  belongs_to :user, optional: true
end
