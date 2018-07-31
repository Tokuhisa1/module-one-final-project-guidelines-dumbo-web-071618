class AddHealingAndAttackToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :attack, :integer
    add_column :items, :healing, :integer
  end
end
