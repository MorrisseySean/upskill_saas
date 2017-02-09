class RemoveTypeFromMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :type, :string
    add_column    :messages, :msg_type, :string
  end
end
