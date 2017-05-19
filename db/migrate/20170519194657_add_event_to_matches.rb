class AddEventToMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column(:events, :event_id, :integer)
    add_column(:matches, :event_id, :integer)
  end
end
