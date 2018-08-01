class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  def add_item(item)
    Inventory.create(character_id: self.id, item_id: item.id)
    self.reload
  end

  def unequip
    self.strength-= self.items.find(self.equip).attack
    self.equip = 0
    self.save
    items
  end



  def equips(new_item)
    #unequip.(item)
    #equips an item then unequips the previous Item
    #updates stats of character as well
    #the new item is already in the backpack
    if self.equip > 0
      self.unequip
    end
    self.equip = new_item.id
    self.strength+= new_item.attack
    self.save

  end

  def use_item(item)
    heal_by = Item.find_by(item.id)
    puts " #{self.name} just used #{item.name}."
    self.health += item.healing
    self.reload
    drop_item(heal_by)
  end

  def drop_item(delete_item)
    drop_all = delete_item.inventories.select do |inventory|
      inventory.character == self
    end
    drop_all.each do |inventory|
      inventory.destroy
    end
    self.reload

    puts  " #{self.name} dropped #{delete_item.name}."
  end
end
