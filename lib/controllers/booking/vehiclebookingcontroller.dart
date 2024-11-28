import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleBookingController extends GetxController {
  final bookingFormKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> dropdownItems = [
    {'id': 1, 'name': "My Self"},
    {'id': 2, 'name': "Other"},
  ];
  // Selected dropdown value
  String? selectedItem;
  String? empName;
  String? empID;

  @override
  void onInit() {
    // TODO: implement onInit
    loadLoginData();
    super.onInit();
  }

  void handleDropdown(newValue) {
    selectedItem = newValue.toString();
    update();
  }

  Future<void> loadLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    log("LoadingData");
    empID = pref.getString("deptID").toString();
    empName = '${pref.getString('firstName')} ${pref.getString('lastName')}';
    log("EMPID $empName");
    update();
  }
}
