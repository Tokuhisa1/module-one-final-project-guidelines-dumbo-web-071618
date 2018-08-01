class SetDefaultEquipValueForCharacters < ActiveRecord::Migration[5.2]
  def change
    change_column :characters, :equip, :integer, :default => 0
  end
end
