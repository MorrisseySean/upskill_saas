class AddEventIdToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column(:events, :event_id, :integer)
  end
end
