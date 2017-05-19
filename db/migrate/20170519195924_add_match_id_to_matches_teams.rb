class AddMatchIdToMatchesTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column(:matches_teams, :event_id, :integer)
    add_column(:matches_teams, :match_id, :integer)
  end
end
