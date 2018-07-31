class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  def add_item(item)
    Inventory.new(character_id: self.id, item_id: item.id)
  end


  def equip(item)
    #unequip.(item)
    #we need an equip method that goes in and changes the value of the inventory
    Inventory.new(character_id: self.id, item_id: item.id)
  end

  def use_item(item)

    puts " #{self.name} just used #{item.name}."
  end

  def drop_item(item)
    puts  " #{self.name} dropped #{item.name}."
  end

end
