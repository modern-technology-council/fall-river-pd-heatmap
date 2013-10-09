class CallLog < ActiveRecord::Base
  mount_uploader :filename, CallLogUploader
  after_save :extract_actions

  def self.parse(call_log)
    log_data = PDF::Reader.new call_log.filename.file.file
    log_data.pages.each do |page|
      page = page.text
      page = page.gsub(/rall River.+\n.+/, '').gsub(/^[\s]*$\n/, '')
      date = nil
      if page =~ /For\sDate:\s([^\s]+)/
        p $1
        date = $1
      end
      page.scan(/\s[0-9]+\s(.+)\n.+Add.ess\s*:\s*(.+)/) do |desc, addr|
        event = PoliceAction.new
        event.action_datetime =  DateTime.parse(date) rescue nil
        event.description = desc
        event.address = addr.gsub(/IFAL/, '[FAL').gsub(/^.+\-\s*/, '').gsub(/apt.+$/i, '').gsub(/\[.+\]/, '').strip + ' Fall River, MA'
        event.display_address = addr.gsub(/IFAL/, '[FAL')
        sleep 1
        coords = Geocoder.search(event.address)
        if coords.present?
          event.lon = coords[0].longitude
          event.lat = coords[0].latitude
        end
        event.save
      end
    end
  end

  protected

  def extract_actions
    CallLog.parse self
  end

  
end
