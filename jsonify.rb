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
