import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/screens/patient/home/patient_home_view.dart';
import 'package:medswift/screens/patient/reports/patient_reports.dart';
import 'package:medswift/screens/patient/reports/patient_reports_view.dart';
import 'package:medswift/screens/patient/settings/patient_settings_view.dart';
import 'package:medswift/shared/colors.dart';

import '../../controller/patient_landing_view_ctr.dart';

final _patientLandingViewCtr = Get.put(PatientLandingViewCtr());
const _views = [
  PatientHomeView(),
  PatientReports(),
  PatientSettingsView(),
];

class PatientLandingView extends StatelessWidget {
  const PatientLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: const CustomBody(),
      bottomNavigationBar: const CustomBottomNavBar(),
      // floatingActionButton: const CustomFAB(),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _patientLandingViewCtr,
      builder: (_) {
        if (_patientLandingViewCtr.currentIndex == 0) {
          return FloatingActionButton(
            backgroundColor: secondary,
            onPressed: () {},
            child: const Icon(Icons.add),
          );
        }
        return Container();
      },
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _patientLandingViewCtr,
      builder: (_) {
        return _views[_patientLandingViewCtr.currentIndex];
      },
    );
  }
}

PreferredSizeWidget customAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: secondary,
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {},
      )
    ],
    title: RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Med",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "swift",
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _patientLandingViewCtr,
      builder: (_) {
        return BottomNavigationBar(
          onTap: (value) {
            _patientLandingViewCtr.setCurrentIndex(value);
          },
          currentIndex: _patientLandingViewCtr.currentIndex,
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
        );
      },
    );
  }
}
