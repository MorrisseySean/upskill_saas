class UpdateEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :type, :string
    add_column    :events, :event_type, :string
    add_column    :events, :league_id, :integer
  end
end
