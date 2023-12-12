import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/controller/patient_home_ctr.dart';
import 'package:medswift/models/alert_model.dart';
import 'package:medswift/screens/patient/home/widgets/ambulance_map.dart';
import 'package:medswift/screens/patient/home/widgets/book_appointment.dart';
import 'package:medswift/screens/patient/home/widgets/near_by_view.dart';
import 'package:medswift/services/device/get_location.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:medswift/shared/loading_widget.dart';
import 'package:medswift/shared/route.dart';
import '../../../controller/authentication_ctr.dart';
import 'widgets/qr_tile.dart';

final _authCtr = Get.put(AuthCtr());
final _patientHomeCtr = Get.put(PatientHomeCtr());

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authCtr.setUserData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QRTile(),
              const Divider(),
              ListTile(
                onTap: () {
                  pushRoute(const BookAppointmentView(), context);
                },
                title: const Text("Book appointment"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  pushRoute(const NearByView(), context);
                },
                title: const Text("Health care near me"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Alert for ambulance :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder(
                  init: _patientHomeCtr,
                  builder: (_) {
                    if (_patientHomeCtr.isAlerted) {
                      return const SizedBox(
                        height: 200,
                        child: AmbulanceMap(),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final position =
                              await GetLocation().getCurrentUserPosition();
                          await Database().createAlert(
                            AlertModel(
                              latitude: position.latitude,
                              longitude: position.longitude,
                              patientId: _authCtr.userData!.id,
                              patientName: _authCtr.userData!.name,
                              id: _authCtr.userData!.id,
                            ),
                          );
                          _patientHomeCtr.toggleAlert();
                        },
                        child: const Text("Create alert"),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
