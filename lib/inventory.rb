class Inventory < ActiveRecord::Base
  belongs_to :character
  belongs_to :item

  #I feel like for inventory we need an array of items in the Hash
  #Im thinking you can hold a weapon and a back pack because if we
  #equip and unequip items then that means sotrage or even if its one then you can't hold
  #a health potion, well it is a hash so we can go through I guess

end
