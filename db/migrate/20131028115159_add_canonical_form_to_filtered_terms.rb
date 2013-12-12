class AddCanonicalFormToFilteredTerms < ActiveRecord::Migration
  def change
    add_column :filtered_terms, :canonical_form, :text
  end
end
