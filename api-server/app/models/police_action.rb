class PoliceAction < ActiveRecord::Base

  def self.find_in_datetime_range(start_datetime, end_datetime)
    PoliceAction.where :action_datetime => start_datetime..end_datetime
  end

end
