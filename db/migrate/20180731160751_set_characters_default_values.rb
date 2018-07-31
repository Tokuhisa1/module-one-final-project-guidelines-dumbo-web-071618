class SetCharactersDefaultValues < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :strength, :integer, :default => 5
    add_column :characters, :health, :integer, :default => 10
    change_column :characters, :level, :integer, :default => 1
    change_column :characters, :xp, :integer, :default => 0
  end
end
