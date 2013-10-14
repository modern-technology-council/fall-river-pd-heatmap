class CreateFilteredTerms < ActiveRecord::Migration
  def change
    create_table :filtered_terms do |t|
      t.text :key_phrase

      t.timestamps
    end
  end
end
