import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/home/homepage.dart';
import '../../views/landingpage/landingpage.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getLoginStatus().then((status) {
      if (status) {
        navigateToHome();
      } else {
        navigateToLogin();
      }
    });
    super.onInit();
  }

  getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (prefs.getBool('isLogin') == null) {
      return false;
    } else {
      return true;
    }
  }

  navigateToHome() {
    Timer(const Duration(seconds: 3), () => Get.offAll(() => const HomePage()));
  }

  navigateToLogin() {
    Timer(const Duration(seconds: 3),
        () => Get.offAll(() => const LandingPage()));
  }
}
