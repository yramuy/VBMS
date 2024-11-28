import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiservice/apiservice.dart';

class ViewDriversController extends GetxController {
  List driversList = [];
  String airportRegId = "";
  String supplierId = "";
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    loadLoginData();
    super.onInit();
  }

  loadLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    airportRegId = pref.getString("airportRegId").toString();
    supplierId = pref.getString('supplierId').toString();
    log("Line 27 and 28");
    log(pref.getString("airportRegId").toString());
    log(pref.getString("supplierId").toString());
    loadDriversList();
    update();
  }

  void loadDriversList() {
    ApiService.get(
        'driverList?airportRegId=$airportRegId&supplierId=$supplierId')
        .then((success) {
      log('status code is ${success.statusCode}');
      if (success.statusCode == 200) {
        var data = jsonDecode(success.body);
        log('response is $data');
        log(data['status'].toString());
        if (data['status'].toString() == 'true') {
          driversList = data['data'];
          log('driversList is $driversList');
          isLoading = false;
          update();
        }
        update();
      } else {
        Get.rawSnackbar(
            message: 'Something went wrong, Please try again later');
      }
      isLoading = false;
      update();
    });

    update();
  }
}