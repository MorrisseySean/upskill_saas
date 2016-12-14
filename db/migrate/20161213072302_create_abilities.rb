class CreateAbilities < ActiveRecord::Migration[5.0]
  def change
    create_table :abilities do |t|
      t.integer :freelancer_id
      t.integer :ab_index
      t.string  :damage
      t.string  :heal
      t.string  :shield
      t.string  :energy
      t.string  :cooldown
      t.string  :range
      t.timestamps
    end
  end
end
