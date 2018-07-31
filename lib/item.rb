class Item < ActiveRecord::Base
  has_many :inventories
  has_many :characters, through: :inventories
end
