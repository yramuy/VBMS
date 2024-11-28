import 'dart:developer';

import 'package:adanivehiclebooking/controllers/booking/vehiclebookingcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleBooking extends StatefulWidget {
  const VehicleBooking({super.key});

  @override
  State<VehicleBooking> createState() => _VehicleBookingState();
}

class _VehicleBookingState extends State<VehicleBooking> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleBookingController>(
        init: VehicleBookingController(),
        builder: (vb) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
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
                  "Vehicle Booking",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: vb.bookingFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Booking For",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          // DropdownButtonFormField(
                          //   style: const TextStyle(
                          //       fontSize: 14, color: Color(0xFF2a2a2a)),
                          //   value: vb.selectedItem,
                          //   decoration: InputDecoration(
                          //     hintText: "Select booking type",
                          //       border: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.grey, width: 1),
                          //           borderRadius: BorderRadius.circular(8)),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.grey, width: 1),
                          //           borderRadius: BorderRadius.circular(8)),
                          //       errorBorder: OutlineInputBorder(
                          //           borderSide:
                          //           BorderSide(color: Colors.red, width: 1),
                          //           borderRadius: BorderRadius.circular(8))),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return "Please select booking type";
                          //     }
                          //     return null;
                          //   },
                          //   items: vb.dropdownItems
                          //       .map<DropdownMenuItem<String>>((value) {
                          //     return DropdownMenuItem(
                          //       value: value['id'].toString(),
                          //       child: Text(value['name'].toString()),
                          //     );
                          //   }).toList(),
                          //   onChanged: (newValue) {
                          //     vb.handleDropdown(newValue);
                          //     log('selected booking type value is $newValue');
                          //   },
                          // ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.withOpacity(0.2)
                            ),
                            child: TextFormField(
                              // controller: ad.firstName,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: vb.empName,
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                            color: Colors.black54, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.black54, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return "First Name is required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ));
  }
}
