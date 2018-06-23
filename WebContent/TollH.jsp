<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <title>Waypoints</title>
    <style>
	.navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    
    .row.content {height: 460px}
    
    /* Set gray background color and 100% height */
    
    /* Set black background color, white text and some padding */
    
    footer {
      background-color: #000000;
      color: white;
      padding: 20px;
      width: 153%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
        
      .row.content {height:auto;} 
    }
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
        float: left;
        width: 70%;
        height: 100%;
      }
      #right-panel {
        margin: 20px;
        border-width: 2px;
        width: 20%;
        height: 400px;
        float: left;
        text-align: left;
        padding-top: 0;
      }
      #directions-panel {
        margin-top: 10px;
        background-color: #FFEE77;
        padding: 10px;
        overflow: scroll;
        height: 174px;
      }
    </style>
  </head>
  <body>
   <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">DriveNow
	</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
	
      <ul class="nav navbar-nav">	
        <li><a href="Home.html">Home</a></li>
        <li><a href="Maps.jsp">Maps</a></li>
        <li><a href="Hotels.jsp">Hotels</a></li>
		<li class="active"><a href="#">Tolls</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="Login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        <li><a href="Register.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      </ul>
    </div>
  </div>
</nav>
    
  
    <div id="map"></div>
    <div id="right-panel">
    <div>
    <b>Source:</b>
    <select id="start">
      <option value="Mumbai, Maharashtra">Mumbai, Maharashtra</option>
      <option value="Pune, Maharashtra">Pune, Maharashtra</option>
      <option value="Bangalore, Karnataka">Bangalore, Karnataka</option>
	  <option value="Chennai, Tamil Nadu">Chennai, Tamil Nadu</option>
	</select>
    <br>
	<b>Tolls:</b> <br>
    <i>(Ctrl+Click or Cmd+Click for multiple selection)</i> <br>
    
	<select multiple id="waypoints" name="waypoints">
      <option value="NH 65 Toll Booth, Mumbai Highway, Telangana">Kamkole Toll Booth</option>
      <option value="Toll Plaza, Bidar, Karnataka">Mangalgi Toll Plaza</option>
	  <option value="Sawaleshwar Toll Plaza, Mohol, Sawaleshwar, Maharashtra">Sawaleshwar Toll Plaza</option>
      <option value="Varwade Toll Plaza, Solapur - Dhule National Highway, Warawade, Maharashtra">Varwade Toll Plaza</option>
	  <option value="Patas Road Toll Plaza, Baramati Daund Road, Baramati, Maharashtra">Patas Toll Plaza</option>
	  <option value="Kasurdi Toll Plaza, Solapur - Pune Highway, Kasurdi, Maharashtra">Kasurdi Toll Plaza</option>
	  <option value="Kawadipath Toll Plaza, Solapur - Pune Highway, Maharashtra">Kawadipath Toll Plaza</option>
    </select>
    <br>
    <b>Destination:</b>
    <select id="end">
      <option value="Hyderabad, Telangana">Hyderabad, Telangana</option>
      <option value="Nagpur, Maharashtra">Nagpur, Maharashtra</option>
      <option value="Ahmedabad, Gujarat">Ahmedabad, Gujarat</option>
      <option value="Kanyakumari, Tamil Nadu">Kanyakumari, Tamil Nadu</option>
    </select>
    <input type="submit" id="submit">
    <br>
    
	
      
	  
    </div>
    <div id="directions-panel"></div>
    </div>

    <script>
      function initMap() {
        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 6,
          center: {lat: 20.5937, lng: 78.9629}
        });
        directionsDisplay.setMap(map);

        document.getElementById('submit').addEventListener('click', function() {
          calculateAndDisplayRoute(directionsService, directionsDisplay);
        });
      }

      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        var waypts = [];
        var checkboxArray = document.getElementById('waypoints');
        for (var i = 0; i < checkboxArray.length; i++) {
          if (checkboxArray.options[i].selected) {
            waypts.push({
              location: checkboxArray[i].value,
              stopover: true
            });
          }
        }

        directionsService.route({
          origin: document.getElementById('start').value,
          destination: document.getElementById('end').value,
          waypoints: waypts,
          optimizeWaypoints: true,
          travelMode: 'DRIVING'
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
            var route = response.routes[0];
            var summaryPanel = document.getElementById('directions-panel');
            summaryPanel.innerHTML = '';
            // For each route, display summary information.
            for (var i = 0; i < route.legs.length; i++) {
              var routeSegment = i + 1;
              summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment +
                  '</b><br>';
              summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
              summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
              summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
            }
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD4w-XouJsyk0ng8DX3DBxEi1UkZ-WEcE0&callback=initMap">
    </script>
  </body>
</html>