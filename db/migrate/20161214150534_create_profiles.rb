class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :team_id
      t.string  :username
      t.string  :glyphtag
      t.string  :favorite_role
      t.string  :favorite_freelancer
      t.text    :bio
      t.attachment    :avatar
      t.timestamps
    end
  end
  
  def self.up
    change_table :profiles do |t|
      t.attachment :avatar
    end
  end
  

  def self.down
    remove_attachment :profiles, :avatar
  end
  
end
