require 'geocoder'

file = File.read(ARGV[0])
file.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
file.encode!('UTF-8', 'UTF-16')
file = file.gsub(/rall River.+\n.+/, '').gsub(/^[\s]*$\n/, '')
date = 'bad'
if file =~ /For\sDate:\s([^\s]+)/
    date = $1
end
output = '{"date" : "' + date + '", "log" : ['
file.scan(/\s[0-9]+\s(.+)\n.+Add.ess\s*:\s*(.+)/) do |desc, addr| 
   address =addr.gsub(/IFAL/, '[FAL').gsub(/^.+\-\s*/, '').gsub(/apt.+$/i, '').gsub(/\[.+\]/, '').strip + ' Fall River, MA'
   coords = nil
   coords = Geocoder.search(address) 
   if coords.length > 0
      output += '{ "lng" : "' + coords[0].longitude.to_s + '", "lat" : "' +  coords[0].latitude.to_s +  '", "description": "' + desc + '", "displayaddr": "' + addr.gsub(/IFAL/, '[FAL') + '", "addr": "' + addr.gsub(/IFAL/, '[FAL').gsub(/^.+\-\s*/, '').gsub(/apt.+$/i, '').gsub(/\[.+\]/, '').strip + '"},' 
   else
      output += '{ "description": "' + desc + '", "displayaddr": "' + addr.gsub(/IFAL/, '[FAL') + '", "addr": "' + addr.gsub(/IFAL/, '[FAL').gsub(/^.+\-\s*/, '').gsub(/apt.+$/i, '').gsub(/\[.+\]/, '').strip + '"},' 
   end
   sleep 1
end
output = output.chomp(',')
output += ']}'
puts output
event = PoliceAction.new event_date: date
 e.pages.each do |page|
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

