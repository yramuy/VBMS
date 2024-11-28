import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/apiservice.dart';
import '../../views/home/homepage.dart';

class EmployeeOrOperatorTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  dynamic argumentData = Get.arguments;
  TabController? tabController;
  final _singUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  bool showSignupPassword = true;
  bool showLoginPassword = true;
  bool showSignupConfirmPassword = true;
  bool _isChecked = false;
  String? selectedAirportValue;
  List airportList = [];
  String? selectedDepartmentValue;
  List departmentList = [];
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController loginEmailIDorMobNo = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobileNo = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    log('argument data is $argumentData');
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    getAirports();
    getDepartments();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _singUpFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Please register to create your account",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(fontSize: 14),
                controller: firstName,
                decoration: const InputDecoration(
                  hintText: "First Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "First name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(fontSize: 14),
                controller: lastName,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Last name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(fontSize: 14),
                controller: emailId,
                decoration: const InputDecoration(
                  hintText: "Email ID",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                ),
                validator: (value) {
                  if (value == null ||
                      !value.contains('@') ||
                      !value.contains('.com')) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mobileNo,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: "Mobile Number",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                ),
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Enter a valid mobile number";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passWord,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    hintText: "Password",
                    border: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showSignupPassword = !showSignupPassword;
                        update();
                      },
                      child: showSignupPassword
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.purple,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.purple,
                            ),
                    )),
                obscureText: showSignupPassword,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPassword,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showSignupConfirmPassword = !showSignupConfirmPassword;
                        update();
                      },
                      child: showSignupConfirmPassword
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.purple,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.purple,
                            ),
                    )),
                obscureText: showSignupConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm password is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                style: const TextStyle(fontSize: 14, color: Color(0xFF2a2a2a)),
                value: selectedAirportValue,
                decoration: const InputDecoration(
                  hintText: "Select Airport",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select an airport";
                  }
                  return null;
                },
                items: airportList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(
                    value: value['airportId'].toString(),
                    child: Text(value['airportName'].toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedAirportValue = newValue;
                  log('selected airport value is $newValue');
                },
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: argumentData == "Operator" ? false : true,
                child: DropdownButtonFormField(
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFF2a2a2a)),
                  value: selectedDepartmentValue,
                  decoration: const InputDecoration(
                    hintText: "Select Department",
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 1.5)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select department";
                    }
                    return null;
                  },
                  items: departmentList.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      value: value['departmentTypeId'].toString(),
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          value['departmentName'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    selectedDepartmentValue = newValue;
                    log('selected Department Value value is $newValue');
                  },
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      _isChecked = !_isChecked;
                      log('check value is $_isChecked');
                      update();
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "Agree to the Terms & Conditions",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  if (_singUpFormKey.currentState!.validate()) {
                    if (_isChecked) {
                      log(passWord.text.toString());
                      log(confirmPassword.text.toString());
                      if (passWord.text.toString() ==
                          confirmPassword.text.toString()) {
                        registerApi();
                      } else {
                        Get.rawSnackbar(
                            snackPosition: SnackPosition.TOP,
                            message:
                                "Password and Confirm Password are not matching",
                            isDismissible: true);
                      }
                    } else {
                      Get.rawSnackbar(
                          snackPosition: SnackPosition.TOP,
                          message: "Please agree terms & conditions",
                          isDismissible: true);
                    }
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  tabController!.index = 1;
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    Text(
                      "Login Here",
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please login to your account",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              controller: loginEmailIDorMobNo,
              decoration: const InputDecoration(
                hintText: "Email ID / Mobile No.",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.5)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email ID / Mobile No. is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              controller: loginPassword,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      showLoginPassword = !showLoginPassword;
                      update();
                    },
                    child: showLoginPassword
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.purple,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.purple,
                          ),
                  )),
              obscureText: showLoginPassword,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (_loginFormKey.currentState!.validate()) {
                  signApi();
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                tabController!.index = 0;
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  Text(
                    "Register Here",
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAirports() async {
    await ApiService.get('getMasterAirports').then((success) {
      // log('status code is ${success.statusCode}');
      if (success.statusCode == 200) {
        var data = jsonDecode(success.body);
        // log('response is $data');
        // log(data['status'].toString());
        if (data['status'].toString() == 'true') {
          airportList = data['data'];
          log('airports list is $airportList');
          update();
        }
        update();
      } else {
        Get.rawSnackbar(
            message: 'Something went wrong, Please try again later');
      }
    });
  }

  getDepartments() async {
    await ApiService.get('getDepartmentList').then((success) {
      log('status code is ${success.statusCode}');
      if (success.statusCode == 200) {
        var data = jsonDecode(success.body);
        log('response is $data');
        log(data['status'].toString());
        if (data['status'].toString() == 'true') {
          departmentList = data['data'];
          log('department list is $departmentList');
          update();
        }
        update();
      } else {
        Get.rawSnackbar(
            message: 'Something went wrong, Please try again later');
      }
    });
  }

  registerApi() async {
    var spocName = "${firstName.text} ${lastName.text}";
    log('spocname is $spocName');
    final body = jsonEncode({
      "mobile": mobileNo.text.toString(),
      "type": "mobile",
      "password": confirmPassword.text.toString(),
      "email": emailId.text.toString(),
      "spocName": spocName.toString(),
      "roleType": argumentData.toString(),
      "airportId": selectedAirportValue,
      "departmentTypeId": selectedDepartmentValue ?? "",
      "firstName": firstName.text.toString(),
      "lastName": lastName.text.toString(),
    });
    log('body-------$body');
    await ApiService.post('auth/signUp', body).then((success) {
      log('status code is ${success.statusCode}');
      var data = jsonDecode(success.body);
      log('response is $data');
      if (success.statusCode == 200) {
        tabController!.index = 1;
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            message: 'Registration Success, please login to continue');
        update();
      } else {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            message: data['message'].toString());
      }
    });
  }

  signApi() async {
    log('entered value is ${loginEmailIDorMobNo.text.toString()}');
    String userNumber = "";
    String userEmail = "";
    if (isNumeric(loginEmailIDorMobNo.text.toString())) {
      userNumber = loginEmailIDorMobNo.text.toString();
      log('user number is $userNumber');
    } else {
      userEmail = loginEmailIDorMobNo.text.toString();
      log('user email is $userEmail');
    }
    final body = jsonEncode({
      "email": userEmail.toString(),
      "password": loginPassword.text.toString(),
      "mobile": userNumber.toString(),
      "roleType": argumentData.toString()
    });
    log('body-------$body');
    await ApiService.post('auth/signIn', body).then((success) {
      log('status code is ${success.statusCode}');
      var data = jsonDecode(success.body);
      log('response is $data');
      if (success.statusCode == 200) {
        saveUserDetails(data['data']);
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP, message: 'Login Success');
        Get.offAll(() => const HomePage());
        update();
      } else {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            message: data['message'].toString());
      }
    });
  }

  bool isNumeric(String str) {
    log('str is $str');
    final numberRegex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    return numberRegex.hasMatch(str);
  }

  saveUserDetails(data) async {
    log('data is $data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setString("userID", data[0]['userId']);
    prefs.setString("spocName", data[0]['spocName']);
    prefs.setString("emailID", data[0]['email']);
    prefs.setString("mobileNo", data[0]['mobile']);
    prefs.setString("userRole", data[0]['roleType']);
    prefs.setString("firstName", data[0]['firstName']);
    prefs.setString("lastName", data[0]['lastName']);
    prefs.setString("airportRegId", data[0]['airportRegId']);
    // prefs.setString(
    //     "deptName",
    //     argumentData == 'Employee'
    //         ? data[0]['departmentData']['departmentName']
    //         : "");
    // prefs.setString(
    //     "deptID",
    //     argumentData == 'Employee'
    //         ? data[0]['departmentTypeId']
    //         : "");
    prefs.setString(
        "supplierId", argumentData == 'Operator' ? data[0]['supplierId'] : "");
    // prefs.setString("airportName", data[0]['masterAirportData']['airportName']);
    log('shared preferencses==============');
    log(prefs.getBool('isLogin').toString());
    log(prefs.getString('userID').toString());
    log(prefs.getString('spocName').toString());
    log(prefs.getString('emailID').toString());
    log(prefs.getString('mobileNo').toString());
    log(prefs.getString('userRole').toString());
    log(prefs.getString('firstName').toString());
    log(prefs.getString('lastName').toString());
    log(prefs.getString('deptName').toString());
    log(prefs.getString('supplierId').toString());
    log(prefs.getString('airportName').toString());
    log(prefs.getString('airportRegId').toString());
    log(prefs.getString('deptID').toString());
    log('shared preferencses==============');
  }
}
