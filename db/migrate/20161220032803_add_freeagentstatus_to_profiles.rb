class AddFreeagentstatusToProfiles < ActiveRecord::Migration[5.0]
  def up
    add_column(:profiles, :freeagent, :boolean, default: false)
  end
end
