class FilteredTerm < ActiveRecord::Base
  before_commit :canonicalize

  protected

  def canonicalize
    canonical_form = key_phrase.gsub(/\s/,'').downcase
  end
  
end
