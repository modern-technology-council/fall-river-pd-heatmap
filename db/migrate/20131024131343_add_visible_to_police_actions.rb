class AddVisibleToPoliceActions < ActiveRecord::Migration
  def change
    add_column :police_actions, :visible, :boolean, :default => true
  end
end
