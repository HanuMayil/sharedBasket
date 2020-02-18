class BasketMember < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :basket
end
