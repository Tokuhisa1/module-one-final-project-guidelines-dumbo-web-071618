class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.boolean :weapon
    end
  end
end
