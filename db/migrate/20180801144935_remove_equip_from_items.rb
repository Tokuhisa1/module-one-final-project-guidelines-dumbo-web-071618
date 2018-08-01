class RemoveEquipFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :equip, :boolean
  end
end
