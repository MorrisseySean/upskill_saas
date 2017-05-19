class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :round
      t.integer :home_team
      t.string  :map_ban
      t.string  :map_pick
      t.attachment :home_pb
      t.attachment :away_pb
      t.attachment :home_end
      t.attachment :away_end
      t.integer :win_team
    end
    
    create_table 'teams_matches', :id => false do |t|
      t.column :team_id, :integer
      t.column :event_id, :integer
    end
    
    create_table 'freelancers_matches', :id => false do |t|
      t.column :freelancer_id, :integer
      t.column :event_id, :integer
    end
    
  end
end
