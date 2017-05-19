class AddAwayTeamToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column(:matches, :away_team, :integer)
  end
end
