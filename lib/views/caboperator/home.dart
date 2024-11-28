import 'dart:developer';
import 'package:adanivehiclebooking/controllers/caboperator/homecontroller.dart';
import 'package:adanivehiclebooking/views/caboperator/vehicle/vehiclehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'driver/driverhome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
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
                    onTap: () {},
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
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/vehicle_icon.png'),
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Vehicle",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
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
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/images/driver_icon.png'),
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Driver",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
