class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  def add_item(item)
    Inventory.create(character_id: self.id, item_id: item.id)
  end

  def unequip
    un_item = []
    items.each do |item|
      if item.equip == true
        un_item = Inventory.find_by(character_id: self.id, item_id:item.id)
        un_item.character_id = nil
        Inventory.find_by(character_id: self.id).strength -= item.attack
      end
      un_item
    end
  end

  def equip(new_item)
    self.unequip
    all_items.each do |item|
      if item.id == new_item.id
        self.strength += new_item.attack
        equip_item = Inventory.find_by(item_id: new_item.id)
        equip_item.equip = true
      end
    end
  end

  def use_item(item)
    heal_by = Item.find_by(item.id)
    puts " #{self.name} just used #{item.name}."
    self.health += item.healing
    drop_item(heal_by)
  end

  def drop_item(delete_item)
        delete_this = Inventory.find_by(character_id: self.id, item_id:delete_item.id)
        delete_this.item_id = nil
    puts  " #{self.name} dropped #{delete_item.name}."
  end
end
