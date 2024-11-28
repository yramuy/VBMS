import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class FlutterMapController extends GetxController {
  final Rx<LatLng?> startPoint = Rx<LatLng?>(null);
  final Rx<LatLng?> endPoint = Rx<LatLng?>(null);
  final RxList<Marker> markers = <Marker>[].obs;
  final RxList<Polyline> polyline = <Polyline>[].obs;

  final String apiKey =
      '1f7e8113-9134-4d1e-89a7-cb1a996e6208'; // Replace with your API key

  // Observable to track selected map style (street/satellite)
  final RxString mapStyle = 'street'.obs;

  // Tile URLs for street and satellite views
  final streetViewUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  // final satelliteViewUrl = 'https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}';
  final satelliteViewUrl =
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
  @override
  void onInit() {
    super.onInit();
    log('Controller initialized');
    _requestLocationPermission();
    _setCurrentLocation(); // Set default start point to current location (if available)
  }

  // Set route and markers based on points
  void setRoute() {
    if (startPoint.value != null && endPoint.value != null) {
      markers.assignAll([
        _buildMarker(startPoint.value!, 'Start', Colors.blue),
        _buildMarker(endPoint.value!, 'End', Colors.red),
      ]);
      fetchRoute();
    }
  }

  // Fetch the route from GraphHopper API
  fetchRoute() async {
    if (startPoint.value == null || endPoint.value == null) return;

    final url = 'https://graphhopper.com/api/1/route?'
        'point=${startPoint.value!.latitude},${startPoint.value!.longitude}&'
        'point=${endPoint.value!.latitude},${endPoint.value!.longitude}&'
        'vehicle=car&locale=en&points_encoded=false&key=$apiKey';
    log('======url=======');
    log(url);
    log('=======url======');
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['paths'] != null && data['paths'].isNotEmpty) {
          final routePoints = data['paths'][0]['points']['coordinates'];

          // Convert to LatLng list for polyline
          final List<LatLng> latLngPoints = routePoints
              .map<LatLng>((coord) => LatLng(coord[1], coord[0])) // [lat, lng]
              .toList();
          log('======points=======');
          log(latLngPoints.toString());
          log('========points=====');
          // Set polyline
          // polyline.clear();
          polyline.add(
            Polyline(
              points: latLngPoints,
              color: Colors.blue,
              strokeWidth: 6.0,
            ),
          );
        } else {
          log('No paths found in response.');
        }
      } else {
        log('Failed to fetch route: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Error fetching route: $e');
    }
  }

  // Set either the start or end point
  void setPoint(LatLng point, bool isStart) {
    if (isStart) {
      startPoint.value = point;
    } else {
      endPoint.value = point;
    }
    setRoute();
  }

  // Set the current location as the default start point (only if not already set)
  Future<void> _setCurrentLocation() async {
    Position? position = await _getCurrentLocation();
    if (position != null && startPoint.value == null) {
      startPoint.value = LatLng(position.latitude, position.longitude);
      setRoute();
      log('current location points==============>>>>>>>');
      log(position.latitude.toString());
      log(position.longitude.toString());
    }
  }

  // Get current location if permission is granted
  Future<Position?> _getCurrentLocation() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      return null;
    }
  }

  // Request location permission
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }

  // Helper method to create markers
  Marker _buildMarker(LatLng point, String label, Color color) {
    return Marker(
      point: point,
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_pin, size: 50, color: color),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  // Method to toggle between map styles
  void toggleMapStyle(String style) {
    mapStyle.value = style;
  }

}
