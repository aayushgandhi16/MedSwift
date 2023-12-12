import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medswift/controller/doctor_ambulance_tracker_ctr.dart';
import 'package:medswift/screens/doctor/home/widget/text_to_speech_prescription.dart';
import 'package:medswift/services/device/get_location.dart';
import 'package:medswift/shared/route.dart';

final _ambulanceReportCtr = Get.put(DoctorAmbTrackerCtr());

class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                pushRoute(
                  const PrescriptionView(),
                  context,
                );
              },
              title: const Text("Write prescription"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const AmbulanceTracker(),
          ],
        ),
      ),
    );
  }
}

class AmbulanceTracker extends StatefulWidget {
  const AmbulanceTracker({
    Key? key,
  }) : super(key: key);

  @override
  State<AmbulanceTracker> createState() => _AmbulanceTrackerState();
}

class _AmbulanceTrackerState extends State<AmbulanceTracker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
