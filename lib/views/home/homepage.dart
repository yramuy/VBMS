import 'dart:developer';

import 'package:adanivehiclebooking/views/booking/vehiclebooking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/home/homecontroller.dart';
import '../caboperator/driver/driverhome.dart';
import '../caboperator/vehicle/vehiclehome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (hc) => Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/user.png',
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      hc.clearData();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/logout.png',
                        height: 50,
                        width: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.purple,
                centerTitle: true,
              ),
              body: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 30, left: 10),
                child: Column(
                  children: [
                    Visibility(
                      visible: hc.userRole == "Operator" ? true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const VehicleHome());
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                // width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/vehicle_icon.png'),
                                      height: 70,
                                      width: 70,
                                    ),
                                    Text("Vehicle",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {
                                log("Clicked on Driver");
                                Get.to(const DriverHome());
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                // width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/driver_icon.png'),
                                      height: 70,
                                      width: 70,
                                    ),
                                    Text(
                                      "Driver",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: hc.userRole == "Employee" ? true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const VehicleBooking());
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                // width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/vehicle_icon.png'),
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Text("Vehicle Booking",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 150,
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                // width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/driver_icon.png'),
                                      height: 70,
                                      width: 70,
                                    ),
                                    Text(
                                      "My Trips",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
