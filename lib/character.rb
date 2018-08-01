class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  def add_item(item)
    Inventory.create(character_id: self.id, item_id: item.id)
  end

  def unequip
    items.each do |item|
      if item.equip == true
        item.character_id = nil
        self.strength -= item.attack
      end
    end
    self.reload
    items
  end

  def equip(new_item)
    self.unequip
    items.each do |item|
      if item.id == new_item.id
        self.strength += new_item.attack
        new_item.equip = true
      end
    end
    self.reload
    new_item
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
