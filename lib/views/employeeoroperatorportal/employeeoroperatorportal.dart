import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/employeeoroperatorportal/employeeoroperatorportalcontroller.dart';

class EmployeeOrOperatorTabs extends StatelessWidget {
  const EmployeeOrOperatorTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeOrOperatorTabController>(
      init: EmployeeOrOperatorTabController(),
      builder: (etc) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              '${etc.argumentData.toString()} Portal',
              style: const TextStyle(fontSize: 24, color: Color(0xFF2a2a2a)),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              controller: etc.tabController,
              indicatorColor: Colors.white,
              indicator: BoxDecoration(
                color: Colors.purple, // Background color for the selected tab
                borderRadius: BorderRadius.circular(10), // Rounded edges
              ),
              labelColor: Colors.white, // Text color for the selected tab
              unselectedLabelColor:
                  Colors.purple, // Text color for unselected tabs
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Sing Up'),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text('Log In'),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: etc.tabController,
            children: [
              etc.buildSignUpForm(),
              etc.buildLoginForm(),
            ],
          ),
        );
      },
    );
  }
}
