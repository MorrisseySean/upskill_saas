class UpdateTeams < ActiveRecord::Migration[5.0]
  
  def change
    drop_table :teams
    
    create_table :teams do |t|
      t.integer     :user_id
      t.string      :name
      t.text        :description
      t.boolean     :firepower, default: false
      t.boolean     :frontline, default: false
      t.boolean     :support, default: false
      t.boolean     :any, default: true
      t.attachment  :avatar
    end
  end
end

