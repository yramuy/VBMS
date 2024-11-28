import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apiservice/apiservice.dart';
import '../../maps/fluttermaps/fluttermaps.dart';

class TripDetailsController extends GetxController {
  dynamic argData = Get.arguments;
  List tripDetails = [];
  @override
  void onInit() {
    // TODO: implement onInit
    log('argData');
    log(argData);
    getTripDetails();
    super.onInit();
  }

  getTripDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getString('userID').toString());
    var userID = prefs.getString('userID').toString();
    var vehicleID = argData;
    final body = jsonEncode({"user_id": userID, "bookVehicle_id": vehicleID});
    log('body-------$body');
    ApiService.post('bkVhclDetlsById', body,).then((success) {
      var data = jsonDecode(success.body);
      log('response = $data');
      if (data['status'] == 1) {
        tripDetails = data['bkVhclDetlsById'];
        log('tripDetails ===========$tripDetails');
        update();
      }
    });
  }

  gotoTracking() {
    var sLatitude = tripDetails[0]['s_latitude'].toString().isNotEmpty
        ? double.parse(tripDetails[0]['s_latitude'].toString())
        : 0.0;
    var sLongitude = tripDetails[0]['s_longitude'].toString().isNotEmpty
        ? double.parse(tripDetails[0]['s_longitude'].toString())
        : 0.0;
    var dLatitude = tripDetails[0]['d_latitude'].toString().isNotEmpty
        ? double.parse(tripDetails[0]['d_latitude'].toString())
        : 0.0;
    var dLongitude = tripDetails[0]['d_longitude'].toString().isNotEmpty
        ? double.parse(tripDetails[0]['d_longitude'].toString())
        : 0.0;
    LatLng startPoint = LatLng(sLatitude, sLongitude); // San Francisco
    LatLng endPoint = LatLng(dLatitude, dLongitude);
    Get.to(
      () => MapScreen(startPoint: startPoint, endPoint: endPoint),
    );
  }
}
