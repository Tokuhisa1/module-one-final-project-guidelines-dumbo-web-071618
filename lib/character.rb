class Character < ActiveRecord::Base
  has_many :inventories
  has_many :items, through: :inventories

  #attr_accessor :health, :strength, :xp, :level

  def add_item(item)
    Inventory.create(character_id: self.id, item_id: item.id)
  end

  # def backpack
  #   Inventory.where(character_id: self.id)
  #   #returns all inventory tied with the user ex. [character.object, item.object, image.object]
  # end

  # def all_items
  #   all_items = []
  #   backpack.each do |inventory|
  #       all_items << Item.find(inventory.item_id)
  #     end
  #
  #   #returns an array of items associated with the user
  #   all_items
  # end

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
    #unequip.(item)
    #equips an item then unequips the previous Item
    #updates stats of character as well
    #the new item is already in the backpack
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
        # delete_this =  Inventory.find_by(character_id: self.id, item_id:delete_item.id)
        # delete_this.character_id = nil
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
