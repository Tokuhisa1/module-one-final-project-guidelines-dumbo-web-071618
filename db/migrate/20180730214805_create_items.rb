class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :weapon
      #adding boolean to see if item is equipped or not
      t.boolean :equip
    end
  end
end
