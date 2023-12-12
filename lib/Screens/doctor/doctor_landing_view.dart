import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:medswift/screens/doctor/home/doctor_home_view.dart';
import 'package:medswift/screens/patient/patient_landing_view.dart';
import '../../controller/doctor_landing_view_ctr.dart';
import 'settings/doctor_settings_view.dart';
import 'reports/doctor_reports_view.dart';

class DoctorLandingView extends StatefulWidget {
  const DoctorLandingView({Key? key}) : super(key: key);

  @override
  State<DoctorLandingView> createState() => _DoctorLandingViewState();
}

class _DoctorLandingViewState extends State<DoctorLandingView> {
  final List<Widget> viewContainer = const [
    DoctorHomeView(),
    ReportsScreen(),
    DoctorSettingsView(),
  ];

  final doctorLandingViewCtr = Get.put(
    DoctorLandingViewCtr(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: GetBuilder(
        init: doctorLandingViewCtr,
        builder: (controller) =>
            viewContainer[doctorLandingViewCtr.currentIndex],
      ),
      bottomNavigationBar: GetBuilder(
        init: doctorLandingViewCtr,
        builder: (_) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: doctorLandingViewCtr.setScreen,
          currentIndex: doctorLandingViewCtr.currentIndex,
          fixedColor: Colors.blue,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Reports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
