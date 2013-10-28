var Map;
Map = (function() {
function Map(id) {
	this.id = id;
	this.markers = []
}

Map.prototype.clear = function() {
  $('#map-canvas').innerHTML = '';
};

Map.prototype.init = function(start_date, end_date, callback) {
	var geocoder, inits, latlngbounds, map, self, showAddress;
	$('body').removeClass('container');
	map = null;
	inits = function() {
	var mapOptions;
	self = this;
	self.markers = []
	mapOptions = {
		zoom: 8,
		center: new google.maps.LatLng(41.67, -71.17),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	return map = new google.maps.Map($('#map-canvas')[0], mapOptions);
	};
	inits();
	self.map = map
	var mcOptions = {zoomOnClick: false};
	var markerCluseter = new MarkerClusterer(map, [], mcOptions)
	google.maps.event.addListener(markerCluseter, 'clusterclick', function(cluster) {
		//console.log(this);
		//console.log(cluster);
		var info = new google.maps.MVCObject;
		info.set('position', cluster.center_);

		var infowindow = new google.maps.InfoWindow({maxHeight: 500, autoScroll: true});
		content = '<div style="max-height: 300px; overflow-y: auto;">'
		for (i in cluster.markers_) {
			content += '<h3>' + cluster.markers_[i].title + '</h3><p>Address: ' + cluster.markers_[i].displayadder + '</p>'
		}
		content += '</div>'
		//console.log(content);
		infowindow.setContent(content)
		infowindow.open(self.map, info);
	})
	geocoder = new google.maps.Geocoder();
	latlngbounds = new google.maps.LatLngBounds();
	showAddress = function(desc, add, showadd, lat, lng) {
		if (lng === null || lng === void 0) {
			//console.log('desc ' + desc);
			if (add !== '') {
				return geocoder.geocode({
					address: add + ' Fall River, MA'
				}, function(res, stat) {
				var infowindow, loc, marker;
				if (stat === google.maps.GeocoderStatus.OK) {
					infowindow = new google.maps.InfoWindow({
						content: '<h3>' + desc + '</h3><p>Address: ' + showadd + '</p>'
					});
					loc = res[0].geometry.location;
					marker = new google.maps.Marker({
						map: map,
						animation: google.maps.Animation.DROP,
						position: loc,
						title: desc,
					});
					latlngbounds.extend(marker.getPosition());
					google.maps.event.addListener(marker, 'click', (function(marker) {
					return function() {
						return infowindow.open(map, marker);
					};
					})(marker));
					map.setCenter(latlngbounds.getCenter());
					self.markers.push(marker)
					markerCluseter.addMarker(marker)
					return map.fitBounds(latlngbounds);
				} else {
					return console.log(stat);
				}
				});
			}
		}
		else {
			//console.log(desc + ' ' + showadd);
			var infowindow = new google.maps.InfoWindow({
				content: '<h3>' + desc + '</h3><p>Address: ' + showadd + '</p>'
			});
			var myCenter=new google.maps.LatLng(lat, lng);
			marker = new google.maps.Marker({
				map: map,
				animation: google.maps.Animation.DROP,
				position: myCenter,
				title: desc,
				displayadder: showadd
			});
			latlngbounds.extend(marker.getPosition());
			google.maps.event.addListener(marker, 'click', (function(marker) {
			return function() {
				return infowindow.open(map, marker);
			};
			})(marker));
			map.setCenter(latlngbounds.getCenter());
			self.markers.push(marker)
			markerCluseter.addMarker(marker)
			return map.fitBounds(latlngbounds);
		}
	};
  var query = '/police_actions.json?';
  console.log(window.location.hash);
  console.log(window.location.hash.substring(1));
  if(window.location.hash) {
    query = query + ('filter=' + window.location.hash.substring(1) + '&');
  }
  if(start_date != '') {
    query = query + 'start_date=' + start_date + '&';
  }
  if(end_date != '') {
    query = query + 'end_date=' + end_date;
  }
	$.getJSON(query, function(json) {
		incidents = json
		i = 1;
    //console.log(json)
		$.each(incidents, function(key, value) {
			showAddress(value.description, value.addr, value.displayaddr, value.lat, value.lng);
		});
		setTimeout(callback, 1000*i+1)
	});
};

Map.prototype.format_date_string = function(d) {
  if(isNaN(d)){
    return '';
  }
  else {
    return d.getUTCFullYear() + (d.getUTCMonth() < 9 ? '0' : '') + (d.getUTCMonth() + 1) + (d.getUTCDate() < 10 ? '0' : '') + d.getUTCDate();
  }
}

return Map;
})();


$(document).ready( function(){
	global_map = new Map();
	global_map.init('','')
	$('#customModal').hide();
	$('#daterange .custom').on('click', function(){
		$('#customModal').slideToggle('slow');
	});

  $('.presets').change(function() {
    global_map.clear();
    global_map = new Map();
    global_map.init($('.presets').val(),'');
  });

  $('#dateRangeSubmit').click(function() {
    global_map.clear();
    var start_date = new Date($('.from').val());
    var end_date = new Date($('.to').val());
    global_map = new Map();
    global_map.init(global_map.format_date_string(start_date), global_map.format_date_string(end_date));
  });
});

