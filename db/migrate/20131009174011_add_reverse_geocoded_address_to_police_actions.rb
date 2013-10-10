class AddReverseGeocodedAddressToPoliceActions < ActiveRecord::Migration
  def change
    add_column :police_actions, :reverse_geocoded_address, :text
  end
end
