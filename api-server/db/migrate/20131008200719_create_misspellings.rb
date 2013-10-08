class CreateMisspellings < ActiveRecord::Migration
  def change
    create_table :misspellings do |t|
      t.text :wrong
      t.text :correct

      t.timestamps
    end
  end
end
