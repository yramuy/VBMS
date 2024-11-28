import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'fluttermapcontroller.dart';

class MapScreen extends StatelessWidget {
  final FlutterMapController mapController = Get.put(FlutterMapController());

  MapScreen({super.key, LatLng? startPoint, LatLng? endPoint}) {
    if (startPoint != null) {
      mapController.startPoint.value = startPoint;
    }
    if (endPoint != null) {
      mapController.endPoint.value = endPoint;
    }
    mapController.setRoute();
  }

  @override
  Widget build(BuildContext context) {
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
          'Tracking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        // actions: [
        //   // DropdownButton to select map style
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: DropdownButton<String>(
        //       dropdownColor: const Color(0xFF2c3252),
        //       underline: Container(
        //         decoration: const ShapeDecoration(
        //           shape: RoundedRectangleBorder(
        //             side: BorderSide(
        //                 width: 1.0,
        //                 style: BorderStyle.none,
        //                 color: Colors.white),
        //           ),
        //         ),
        //       ),
        //       iconEnabledColor: Colors.white,
        //       style: const TextStyle(color: Colors.white),
        //       value: mapController.mapStyle.value,
        //       items: const [
        //         DropdownMenuItem(value: 'street', child: Text('Street View')),
        //         DropdownMenuItem(
        //             value: 'satellite', child: Text('Satellite View')),
        //       ],
        //       onChanged: (value) {
        //         if (value != null) {
        //           mapController.toggleMapStyle(value); // Toggle map style
        //         }
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: Obx(() {
        return FlutterMap(
          options: MapOptions(
            initialCenter: mapController.startPoint.value ?? const LatLng(0, 0),
            initialZoom: 15,
            // onTap: (tapPosition, point) {
            //   if (mapController.startPoint.value == null) {
            //     mapController.setPoint(point, true);
            //   } else {
            //     mapController.setPoint(point, false);
            //   }
            // },
          ),
          children: [
            TileLayer(
              urlTemplate: mapController.mapStyle.value == 'street'
                  ? mapController.streetViewUrl
                  : mapController.satelliteViewUrl,
              subdomains: const ['a', 'b', 'c'], // Subdomains for tile requests
              userAgentPackageName: 'com.example.app',
            ),
            // TileLayer(
            //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // ),
            MarkerLayer(
              markers: mapController.markers,
            ),
            PolylineLayer(
              polylines: mapController.polyline.toList(),
            ),
          ],
        );
      }),
    );
  }
}
