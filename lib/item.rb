class Item < ActiveRecord::Base
  has_many :inventories
  has_many :characters, through: :inventories

  #attr_accessor :attack, :healing, :equip, :weapon,:name

  def self.create_weapon(hash)
    new_item = Item.create(name: hash[:name], weapon: true, attack: hash[:attack])
    Inventory.create(item_id:  new_item.id)
    new_item
  end

  def self.create_potion(name, health)
    new_item = Item.create(name: hash[:name], weapon: false, healing: hash[:healing])
    Inventory.create(item_id: new_item.id)
    new_item
  end

end
