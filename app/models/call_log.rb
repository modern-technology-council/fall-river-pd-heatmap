class CallLog < ActiveRecord::Base
  mount_uploader :filename, CallLogUploader
  after_save :enqueue_extract_action_job

  def self.parse(call_log)
    log_data = PDF::Reader.new call_log.filename.file.file
    log_data.pages.each do |page|
      page = page.text
      page = page.gsub(/rall River.+\n.+/, '').gsub(/^[\s]*$\n/, '')
      page.scan(/\s[0-9]+\s(.+)\n.+Add.ess\s*:\s*(.+)/) do |desc, addr|
        event = PoliceAction.new
        event.action_datetime = call_log.for_date
        event.description = desc
        event.address = addr.gsub(/IFAL/, '[FAL').gsub(/^.+\-\s*/, '').gsub(/apt.+$/i, '').gsub(/\[.+\]/, '').strip + ' Fall River, MA'
        event.display_address = addr.gsub(/IFAL/, '[FAL')
        sleep 1
        coords = Geocoder.search(event.address)
        if coords.present?
          event.lon = coords[0].longitude
          event.lat = coords[0].latitude
          event.reverse_geocoded_address = coords[0].address
        end
        event.save
      end
    end
  end

  def extract_actions
    CallLog.parse self
  end

  protected

  def enqueue_extract_action_job
    CallLogParseJob.create :call_log_id => id
  end
  
end
