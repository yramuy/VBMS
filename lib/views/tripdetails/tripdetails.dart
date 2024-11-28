import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tripdetails/tripdetailscontroller.dart';


class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripDetailsController>(
      init: TripDetailsController(),
      builder: (tdc) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/back_arrow.png',
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: const Color(0xFF2c3252),
            title: const Text(
              'Trip Details',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  tdc.gotoTracking();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/map_icon.png',
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tdc.tripDetails.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFe5e5e5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Table(
                      children: [
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Booked By            :',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF2c3252)),
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['emp_name'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Booked For          :',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF2c3252)),
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['booked_for'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Origin                   :',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['origin'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Pickup                  :',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['pick_up_point'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Dropping              :',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['destination'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Date                      :',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['from_date'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                        TableRow(children: [
                          const TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('Time                     :',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(tdc.tripDetails[index]['from_time'],
                                style: const TextStyle(
                                    fontSize: 16, color: Color(0xFF2c3252))),
                          )),
                        ]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              tdc.gotoTracking();
              // var sLatitude = tdc.tripDetails[0]['s_latitude']
              //         .toString()
              //         .isNotEmpty
              //     ? double.parse(tdc.tripDetails[0]['s_latitude'].toString())
              //     : 0.0;
              // var sLongitude = tdc.tripDetails[0]['s_longitude']
              //         .toString()
              //         .isNotEmpty
              //     ? double.parse(tdc.tripDetails[0]['s_longitude'].toString())
              //     : 0.0;
              // var dLatitude = tdc.tripDetails[0]['d_latitude']
              //         .toString()
              //         .isNotEmpty
              //     ? double.parse(tdc.tripDetails[0]['d_latitude'].toString())
              //     : 0.0;
              // var dLongitude = tdc.tripDetails[0]['d_longitude']
              //         .toString()
              //         .isNotEmpty
              //     ? double.parse(tdc.tripDetails[0]['d_longitude'].toString())
              //     : 0.0;
              // LatLng startPoint =
              //     LatLng(sLatitude, sLongitude); // San Francisco
              // LatLng endPoint = LatLng(dLatitude, dLongitude);
              // Get.to(
              //   () => MapScreen(startPoint: startPoint, endPoint: endPoint),
              // );
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: 300,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFF2c3252),
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Start Trip',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        );
      },
    );
  }
}
