class PoliceAction < ActiveRecord::Base

  scope :suspicious, where("lower(replace(description,' ','')) not in (?)",\
      ['Service Run', 
        'Citizen Needs Info', 
        'Detail Long Term', 
        'Citizen Provides Info', 
        'Business/pharmacy/bank check',
        'Detail Short Term',
        'Car Wash',
        'coffee Break',
        'Lunch',
        'school Traffic Post',
        'Auto Accident',
        'Parking Violations',
        'Illness - Assist FRFD',
        'Officer in Station',
        'Notification',
        'Vehicle Stop',
        'Report Writing',
        'Fuel',
        'Continued Investigation by U D',
        'Auto Accident Unknown Injury'].map{|r| r.gsub(/\s/,'').downcase})

  def self.find_in_datetime_range(start_datetime, end_datetime)
    PoliceAction.where :action_datetime => start_datetime..end_datetime
  end

end
