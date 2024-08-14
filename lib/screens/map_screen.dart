import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
// import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MapScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  // final Location _location = Location();
  LatLng? currentLocation;
  String googleAPIKey = "AIzaSyAHVXPjZfAMQOdENB7-MLU6Suk5FQaO6GM";
  String travelMode = 'driving'; // Default travel mode

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    // final loc = await _location.getLocation();
    // setState(() {
    //   currentLocation = LatLng(loc.latitude!, loc.longitude!);
    // });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getDirections() async {
    // if (currentLocation == null) return;
    //
    // final destination = widget.user['location'];
    // final origin = '${currentLocation!.latitude},${currentLocation!.longitude}';
    // final directionsUrl =
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=$travelMode&key=AIzaSyAHVXPjZfAMQOdENB7-MLU6Suk5FQaO6GM';
    final directionsUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=15.1162419907&destination=104.32306&mode=$travelMode&key=AIzaSyAHVXPjZfAMQOdENB7-MLU6Suk5FQaO6GM';
    print(directionsUrl);
    _launchMaps();
    // final response = await http.get(Uri.parse(directionsUrl));
    // ignore: unused_local_variable
    // final data = json.decode(response.body);

    // Process directions data...
  }

  final String originLatitude = '15.1162419907';
  final String originLongitude = '104.32306';
  final String destinationLatitude = '13.7563';
  final String destinationLongitude = '100.5018';

  Future<void> _launchMaps() async {
    final String googleMapsUrl = 'https://maps.app.goo.gl/Ej3e5wxKkHJazGas5';

    print(googleMapsUrl);
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: currentLocation ??
                    LatLng(15.116241990779411, 104.32306537085313),
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: travelMode,
                  onChanged: (String? newValue) {
                    setState(() {
                      travelMode = newValue!;
                    });
                  },
                  items: <String>['driving', 'walking', 'bicycling', 'transit']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: _getDirections,
                  child: Text('Get Directions'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
