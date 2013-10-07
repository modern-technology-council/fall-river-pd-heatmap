var Map;
Map = (function() {
function Map(id) {
	this.id = id;
	this.markers = []
}

Map.prototype.init = function(callback) {
	var geocoder, inits, latlngbounds, map, self, showAddress;
	$('body').removeClass('container');
	map = null;
	inits = function() {
	var mapOptions;
	self = this;
	self.markers = []
	mapOptions = {
		zoom: 8,
		center: new google.maps.LatLng(-34.397, 150.644),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	return map = new google.maps.Map($('#map-canvas')[0], mapOptions);
	};
	inits();
	self.map = map
	var mcOptions = {gridSize: 50, maxZoom: 15};
	var markerCluseter = new MarkerClusterer(map) //, [], mcOptions)
	geocoder = new google.maps.Geocoder();
	latlngbounds = new google.maps.LatLngBounds();
	showAddress = function(desc, add, showadd, lat, lng) {
		console.log(add)
		if (lng === null || lng === void 0) {
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
					console.log(loc)
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
			infowindow = new google.maps.InfoWindow({
				content: '<h3>' + desc + '</h3><p>Address: ' + showadd + '</p>'
			});
			var myCenter=new google.maps.LatLng(lat, lng);
			marker = new google.maps.Marker({
				map: map,
				animation: google.maps.Animation.DROP,
				position: myCenter,
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
		}
	};
	$.getJSON('logs/Call_log_9_21_13.json', function(json) {
		incidents = json.log
		i = 1;
		$.each(incidents, function(key, value) {
			showAddress(value.description, value.addr, value.displayaddr, value.lat, value.lng);
		});
		setTimeout(callback, 1000*i+1)
	});
};


return Map;

})();
map = new Map()
map.init(function() {
})
