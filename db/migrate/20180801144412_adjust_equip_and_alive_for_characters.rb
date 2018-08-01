class AdjustEquipAndAliveForCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :equip, :integer
    remove_column :characters, :alive, :boolean
  end
end
