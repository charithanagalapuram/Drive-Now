<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Maps</title>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

.row.content {
	height: auto;
}

.sidenav {
	padding-top: 20px;
	background-color: #C0C0C0;
	height: 300%;
}

footer {
	background-color: #000000;
	color: white;
	padding: 15px;
}

@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.controls {
	margin-top: 10px;
	border: 1px solid transparent;
	border-radius: 2px 0 0 2px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	height: 32px;
	outline: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#origin-input, #destination-input {
	background-color: #fff;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	margin-left: 12px;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 200px;
}

#origin-input:focus, #destination-input:focus {
	border-color: #4d90fe;
}

#mode-selector {
	color: #fff;
	background-color: #4d90fe;
	margin-left: 12px;
	padding: 5px 11px 0px 11px;
}

#mode-selector label {
	font-family: Roboto;
	font-size: 13px;
	font-weight: 300;
}
</style>
</head>
<body>
	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand">Drive Now</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li><a href="Home.html">Home</a></li>
				<li class="active"><a href="#">Maps</a></li>
				<li><a href="Hotels.jsp">Hotels</a></li>
				<li><a href="TollH.jsp">Tolls</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="Login.jsp"><span
						class="glyphicon glyphicon-log-in"></span> Login</a></li>
				<li><a href="Register.jsp"><span
						class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			</ul>
		</div>
	</div>
	</nav>

	<input id="origin-input" class="controls" type="text"
		placeholder="Enter an origin location">

	<input id="destination-input" class="controls" type="text"
		placeholder="Enter a destination location">

	<div id="mode-selector" class="controls">
		<input type="radio" name="type" id="changemode-walking"
			checked="checked"> <label for="changemode-walking">Walking</label>

		<input type="radio" name="type" id="changemode-transit"> <label
			for="changemode-transit">Transit</label> <input type="radio"
			name="type" id="changemode-driving"> <label
			for="changemode-driving">Driving</label>
	</div>

	<div id="map"></div>
	<div id="listing">
		<table id="resultsTable">
			<tbody id="results"></tbody>
		</table>
	</div>

	<div style="display: none">
		<div id="info-content">
			<table>
				<tr id="iw-url-row" class="iw_table_row">
					<td id="iw-icon" class="iw_table_icon"></td>
					<td id="iw-url"></td>
				</tr>
				<tr id="iw-address-row" class="iw_table_row">
					<td class="iw_attribute_name">Address:</td>
					<td id="iw-address"></td>
				</tr>
				<tr id="iw-phone-row" class="iw_table_row">
					<td class="iw_attribute_name">Telephone:</td>
					<td id="iw-phone"></td>
				</tr>
				<tr id="iw-rating-row" class="iw_table_row">
					<td class="iw_attribute_name">Rating:</td>
					<td id="iw-rating"></td>
				</tr>
				<tr id="iw-website-row" class="iw_table_row">
					<td class="iw_attribute_name">Website:</td>
					<td id="iw-website"></td>
				</tr>
			</table>
		</div>
	</div>

	<script>
		// This example requires the Places library. Include the libraries=places
		// parameter when you first load the API. For example:
		// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

		function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
				mapTypeControl : false,
				center : {
					lat : -33.8688,
					lng : 151.2195
				},
				zoom : 13
			});

			new AutocompleteDirectionsHandler(map);
		}

		/**
		 * @constructor
		 */
		function AutocompleteDirectionsHandler(map) {
			this.map = map;
			this.originPlaceId = null;
			this.destinationPlaceId = null;
			this.travelMode = 'WALKING';
			var originInput = document.getElementById('origin-input');
			var destinationInput = document.getElementById('destination-input');
			var modeSelector = document.getElementById('mode-selector');
			this.directionsService = new google.maps.DirectionsService;
			this.directionsDisplay = new google.maps.DirectionsRenderer;
			this.directionsDisplay.setMap(map);

			var originAutocomplete = new google.maps.places.Autocomplete(
					originInput, {
						placeIdOnly : true
					});
			var destinationAutocomplete = new google.maps.places.Autocomplete(
					destinationInput, {
						placeIdOnly : true
					});

			this.setupClickListener('changemode-walking', 'WALKING');
			this.setupClickListener('changemode-transit', 'TRANSIT');
			this.setupClickListener('changemode-driving', 'DRIVING');

			this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
			this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');

			this.map.controls[google.maps.ControlPosition.TOP_LEFT]
					.push(originInput);
			this.map.controls[google.maps.ControlPosition.TOP_LEFT]
					.push(destinationInput);
			this.map.controls[google.maps.ControlPosition.TOP_LEFT]
					.push(modeSelector);
		}

		// Sets a listener on a radio button to change the filter type on Places
		// Autocomplete.
		AutocompleteDirectionsHandler.prototype.setupClickListener = function(
				id, mode) {
			var radioButton = document.getElementById(id);
			var me = this;
			radioButton.addEventListener('click', function() {
				me.travelMode = mode;
				me.route();
			});
		};

		AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(
				autocomplete, mode) {
			var me = this;
			autocomplete.bindTo('bounds', this.map);
			autocomplete
					.addListener(
							'place_changed',
							function() {
								var place = autocomplete.getPlace();
								if (!place.place_id) {
									window
											.alert("Please select an option from the dropdown list.");
									return;
								}
								if (mode === 'ORIG') {
									me.originPlaceId = place.place_id;
								} else {
									me.destinationPlaceId = place.place_id;
								}
								me.route();
							});

		};

		AutocompleteDirectionsHandler.prototype.route = function() {
			if (!this.originPlaceId || !this.destinationPlaceId) {
				return;
			}
			var me = this;

			this.directionsService.route({
				origin : {
					'placeId' : this.originPlaceId
				},
				destination : {
					'placeId' : this.destinationPlaceId
				},
				travelMode : this.travelMode
			}, function(response, status) {
				if (status === 'OK') {
					me.directionsDisplay.setDirections(response);
				} else {
					window.alert('Directions request failed due to ' + status);
				}
			});
		};
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD4w-XouJsyk0ng8DX3DBxEi1UkZ-WEcE0&libraries=places&callback=initMap"
		async defer></script>
	<footer class="container-fluid text-center">
	<p>Footer Text</p>
	</footer>
</body>
</html>