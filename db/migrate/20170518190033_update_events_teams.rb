class UpdateEventsTeams < ActiveRecord::Migration[5.0]
  def change
    drop_table 'teams_events'
    
    create_table 'events_teams', :id => false do |t|
      t.column :team_id, :integer
      t.column :event_id, :integer
    end
    
  end
end
