class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :character_id
      t.integer :item_id
    end
  end
end
