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
    #unequip.(item)
    #equips an item then unequips the previous Item
    #updates stats of character as well
    #the new item is already in the backpack
    self.unequip
    all_items.each do |item|
      if item.id == new_item.id
        self.strength += new_item.attack
        equip_item = Inventory.find_by(item_id: new_item.id)
        equip_item.equip = true
      end
    end
<<<<<<< HEAD
# I think I haveto save the changes to the data base here update to inventory
=======
>>>>>>> 5d17b456bce0c36ba4f8aa4cfeca88874037e5ee
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
