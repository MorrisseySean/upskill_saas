class CreateFreelancers < ActiveRecord::Migration[5.0]
  def change
    create_table :freelancers do |t|
      t.string  :name
      t.string  :sub_name
      t.string  :image_url
      t.timestamps
    end
  end
end
