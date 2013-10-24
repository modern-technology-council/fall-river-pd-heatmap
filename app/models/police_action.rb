class PoliceAction < ActiveRecord::Base

  scope :suspicious, -> do 
    where("lower(replace(description,' ','')) not in (?)",\
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
  end

  scope :visible, -> { where(:visible => true) }

  scope :occurred_between, -> (start_datetime, end_datetime) do
    where :action_datetime => start_datetime..end_datetime
  end

  scope :at_nuisance_property, -> do
    count_table = <<-SQL
      INNER JOIN (
        SELECT COUNT(*) AS count_all, latitude as lat, longitude as lon
        FROM police_actions
        GROUP BY lat, lon
        HAVING COUNT(*) > 2
      ) AS p_a

end
