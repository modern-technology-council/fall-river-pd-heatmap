class CreatePoliceActions < ActiveRecord::Migration
  def change
    create_table :police_actions do |t|
      t.float :lat
      t.float :lon
      t.text :description
      t.text :display_address
      t.text :address
      t.datetime :action_datetime

      t.timestamps
    end
  end
end
