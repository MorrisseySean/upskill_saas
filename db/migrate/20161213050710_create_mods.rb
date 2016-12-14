class CreateMods < ActiveRecord::Migration[5.0]
  def change
    create_table :mods do |t|
      t.integer :ability_id
      t.string  :name
      t.string  :description
      t.string  :cost
      t.timestamps
    end
  end
end
