class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string  :name
      t.string  :date
      t.string  :time
      t.string  :type
      t.integer :num_matches
      t.timestamps
    end
    
    create_table 'teams_events', :id => false do |t|
      t.column :team_id, :integer
      t.column :event_id, :integer
    end
  end
end
