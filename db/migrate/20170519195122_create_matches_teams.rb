class CreateMatchesTeams < ActiveRecord::Migration[5.0]
  def change
    create_table 'matches_teams', :id => false do |t|
      t.column :team_id, :integer
      t.column :event_id, :integer
    end
    
    drop_table 'teams_matches'
    
  end
end
