import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medswift/screens/patient/reports/patient_prescriptions_view.dart';
import 'package:medswift/screens/patient/reports/patient_reports_view.dart';
import 'package:medswift/shared/colors.dart';

class PatientReports extends StatelessWidget {
  const PatientReports({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Reports",
              ),
              Tab(
                text: "Prescriptions",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PatientReportsView(),
            PatientPrescriptionsView(),
          ],
        ),
      ),
    );
  }
}
