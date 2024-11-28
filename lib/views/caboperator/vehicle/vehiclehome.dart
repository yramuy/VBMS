import 'dart:developer';

import 'package:adanivehiclebooking/controllers/caboperator/vehicle/vehiclehomecontroller.dart';
import 'package:adanivehiclebooking/views/caboperator/vehicle/addvehicle.dart';
import 'package:adanivehiclebooking/views/caboperator/vehicle/viewvehiclelist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleHome extends StatefulWidget {
  const VehicleHome({super.key});

  @override
  State<VehicleHome> createState() => _VehicleHomeState();
}

class _VehicleHomeState extends State<VehicleHome> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleHomeController>(
        init: VehicleHomeController(),
        builder: (vhc) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
                title: const Text(
                  "Vehicle",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // centerTitle: true,
                backgroundColor: Colors.purple,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 35,
                ),
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
                          Get.off(() => const AddVehicle());
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
                              SizedBox(
                                height: 15,
                              ),
                              Image(
                                image: AssetImage('assets/images/add_icon.png'),
                                height: 80,
                                width: 80,
                              ),
                              Text("Add Vehicle",
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
                          Get.off(() => const ViewVehicleList());
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
                              SizedBox(
                                height: 15,
                              ),
                              Image(
                                image:
                                    AssetImage('assets/images/list_icon.png'),
                                height: 80,
                                width: 80,
                              ),
                              Flexible(
                                child: Text(
                                  "View Vehicle List",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow
                                      .ellipsis, // Ensures text doesn’t overflow
                                ),
                              ),
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
