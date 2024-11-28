import 'dart:convert';
import 'dart:developer';
import 'package:adanivehiclebooking/views/landingpage/landingpage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/apiservice.dart';

class HomePageController extends GetxController {
  List vehicleNotificationDetails = [];
  String userRole = "";
  @override
  void onInit() {
    // TODO: implement onInit
    getTripDetailsNotifications();
    super.onInit();
  }

  getTripDetailsNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getString('userRole').toString());
    userRole = prefs.getString('userRole').toString();
    // final body = jsonEncode({"user_id": userID});
    log('body-------$userRole');
    // await ApiService.post(
    //   'bookVehicleNotifDetails',
    //   body,
    // ).then((success) {
    //   var data = jsonDecode(success.body);
    //   log('response = $data');
    //   if (data['status'] == 1) {
    //     vehicleNotificationDetails = data['bkVhclNotfctnDtls'];
    //     log('vehicleNotificationDetails ===========$vehicleNotificationDetails');
    //     update();
    //   }
    // });
    update();
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.clear();
    log('data cleared');
    Get.offAll(() => const LandingPage());
    update();
  }
}
