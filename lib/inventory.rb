class Inventory < ActiveRecord::Base
  belongs_to :characters
  belongs_to :items
end
