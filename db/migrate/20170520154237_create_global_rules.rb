class CreateGlobalRules < ActiveRecord::Migration[5.0]
  def change
    create_table :global_rules do |t|
      t.integer :fl_bans,   default: 1
      t.integer :map_bans,  default: 1
      t.integer :min_team_size, default: 4
      t.integer :max_team_size, default: 6
    end
  end
end
