class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  attr_accessor :health, :strength, :xp, :level

  def add_item(item)

  end

  def backpack
    Inventory.find_by(character_id: self.id)
  end

  def items
    all_items = []
    backpack.select do |character_hash|
      character_hash[:item_id]
    end
    #returns an array of items associated witht the user
  end

  

  def equip(item)
    #unequip.(item)
    #equips an item then unequips the previous Item
    #updates stats of character as well
    items.collect do |item|
      if item[:item_id] == item

      end

  end

  def use_item(item)

    puts " #{self.name} just used #{item.name}."
  end

  def drop_item(item)
    puts  " #{self.name} dropped #{item.name}."
  end

end
