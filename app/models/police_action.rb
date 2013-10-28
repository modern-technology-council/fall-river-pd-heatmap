class PoliceAction < ActiveRecord::Base

  scope :suspicious, -> do 
    where("lower(replace(description,' ','')) not in (?)", FilteredTerm.all.pluck(&:key_phrase))
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
    SQL
  end

end
