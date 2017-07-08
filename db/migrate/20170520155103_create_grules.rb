class CreateGrules < ActiveRecord::Migration[5.0]
  def change
    
    drop_table 'global_rules'
    
    create_table :grules do |t|
      t.integer :fl_bans,   default: 1
      t.integer :map_bans,  default: 1
      t.integer :min_team_size, default: 4
      t.integer :max_team_size, default: 6
    end
  end
end
