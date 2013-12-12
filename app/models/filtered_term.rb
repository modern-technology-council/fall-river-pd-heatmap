class FilteredTerm < ActiveRecord::Base
  #after_save :canonicalize

  def key_phrase= (kp)
    canonical_form = kp.gsub(/\s/,'').downcase
    super kp
  end

  protected

  def canonicalize
    canonical_form = key_phrase.gsub(/\s/,'').downcase if canonical_form.blank?
    p key_phrase
    p canonical_form
    save if canonical_form.blank?
  end

end
