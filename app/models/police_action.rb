class PoliceAction < ActiveRecord::Base

  scope :top_addresses, -> { count(:group => :reverse_geocoded_address).sort_by {|arr| -arr[1]} }

  scope :suspicious, -> do 
    where("lower(replace(description,' ','')) not in (?)", 
          FilteredTerm.all.pluck(:key_phrase).map{|r| r.gsub(/\s/,'').downcase})
  end

  scope :visible, -> { where(:visible => true) }

  scope :occurred_between, -> (start_datetime, end_datetime) do
    where :action_datetime => start_datetime..end_datetime
  end

  scope :filtered_addresses, -> { where("reverse_geocoded_address NOT IN (?)",
                                        ['685 Pleasant Street, Fall River, MA 02723, USA',
                                          'Fall River, MA, USA'])}

  scope :at_nuisance_property, -> do
    count_table = <<-SQL
      INNER JOIN (
        SELECT COUNT(*) AS count_all, lat, lon
        FROM police_actions
        GROUP BY lat, lon
        HAVING COUNT(*) > 2
      ) p_a ON p_a.lat = police_actions.lat AND p_a.lon = police_actions.lon
    SQL
    joins(count_table).order('p_a.count_all DESC')
  end

end
