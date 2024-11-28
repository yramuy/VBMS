import 'dart:convert';

import 'package:adanivehiclebooking/controllers/viewimage/viewimagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewImageController>(
      init: ViewImageController(),
      builder: (vi) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 20),
            title: const Text('File Viewer',
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Image.memory(
                  base64Decode(vi.argumentData.toString()),
                  fit: BoxFit.contain,
                  excludeFromSemantics: true,
                )),
          ),
        );
      },
    );
  }
}
