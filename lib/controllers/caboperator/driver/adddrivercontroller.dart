import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:adanivehiclebooking/views/caboperator/driver/driverhome.dart';
import 'package:adanivehiclebooking/views/caboperator/driver/viewdrivers.dart';
import 'package:adanivehiclebooking/views/viewimage/viewimage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiservice/apiservice.dart';

class AddDriverController extends GetxController {
  final addDriverFormKey = GlobalKey<FormState>();
  String airportRegId = "";
  String supplierId = "";
  String driverId = "";
  String supplierName = "";
  List names = [];
  List paths = [];
  List baseImg = [];
  File? image, selectedImage;
  final ImagePicker _picker = ImagePicker();
  // File? image, selectedImage;
  FilePickerResult? result;
  bool showPassword = true;
  TextEditingController loginPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailID = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController licenseNumber = TextEditingController();
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    loadLoginData();
    super.onInit();
  }

  loadLoginData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    log("LoadingData");
    airportRegId = pref.getString("airportRegId").toString();
    supplierId = pref.getString('supplierId').toString();
    supplierName = pref.getString('spocName').toString();

    if (argumentData != null && argumentData[0].toString() == "Edit") {
      driverId = argumentData[1]['driverId'];
      firstName.text = argumentData[1]['firstName'];
      lastName.text = argumentData[1]['lastName'];
      emailID.text = argumentData[1]['email'];
      mobileNumber.text = argumentData[1]['mobile'];
      licenseNumber.text = argumentData[1]['driverLicence'];
    }
    update();
  }

  saveDriverData() {
    String body;
    if (driverId.toString() != "") {
      body = jsonEncode({
        "driverId": driverId,
        "email": emailID.text,
        "mobile": mobileNumber.text,
        "password": loginPassword.text,
        "firstName": firstName.text,
        "lastName": lastName.text,
        "fullName": "${firstName.text} ${lastName.text}",
        "driverLicence": licenseNumber.text,
        "airportId": airportRegId.toString(),
        "supplierId": supplierId.toString()
      });
    } else {
      body = jsonEncode({
        "email": emailID.text,
        "mobile": mobileNumber.text,
        "password": loginPassword.text,
        "firstName": firstName.text,
        "lastName": lastName.text,
        "fullName": "${firstName.text} ${lastName.text}",
        "driverLicence": licenseNumber.text,
        "airportRegId": airportRegId.toString(),
        "supplierId": supplierId.toString()
      });
    }

    if (kDebugMode) {
      print("Driver Body $body");
    }

    ApiService.post('/saveAndUpdateDriver', body).then((success) {
      log('status code is ${success.statusCode}');
      var data = jsonDecode(success.body);
      log('response is $data');
      if (success.statusCode == 200) {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            message: data['message'].toString());
        if (driverId != "") {
          Get.off(() => const ViewDrivers());
        } else {
          Get.off(() => const DriverHome());
        }

        update();
      } else {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            message: data['message'].toString());
        update();
      }
    });
  }

  handleUpload(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Add Photo!",
        ),
        content: SizedBox(
          height: 130,
          width: 50,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                  child: const Card(
                    color: Colors.purple,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () async {
                    uploadPhoto(ImageSource.camera);
                    Navigator.pop(context);
                  }),
              GestureDetector(
                child: const Card(
                  color: Colors.purple,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose From Gallery",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  uploadPhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              GestureDetector(
                child: const Card(
                  color: Colors.purple,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadPhoto(ImageSource source) async {
    names = [];
    paths = [];
    baseImg = [];

    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    final File file = File(image!.path);

    try {
      if (image != null) {
        selectedImage = file;
        String fileName = image.path.toString().split('/').last;
        List<int> imageBytes = selectedImage!.readAsBytesSync();
        var imageB64 = base64Encode(imageBytes);
        baseImg.add(imageB64);
        names.add(fileName);
        paths.add(image.path.toString());
        // log('baseImg is $baseImg');
        log('fileName is $fileName');
        log('names is $names');
        log('paths is $paths');

        update();
      }
    } catch (e) {
      log("Error Occured $e");
      update();
    }
    update();
  }

  viewImage(imageData) {
    log('imagedata is $imageData');
    Get.to(() => const ViewImage(), arguments: imageData);
    update();
  }
}
