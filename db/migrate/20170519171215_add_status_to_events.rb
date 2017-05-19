class AddStatusToEvents < ActiveRecord::Migration[5.0]
  def up
    add_column(:events, :status, :string, default: "open")
  end
end
