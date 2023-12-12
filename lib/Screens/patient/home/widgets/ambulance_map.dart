import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medswift/controller/patient_home_ctr.dart';
import 'package:medswift/services/device/get_location.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/services/firebase/database.dart';

final _getLocation = GetLocation();
final _patientHomeCtr = Get.put(PatientHomeCtr());

class AmbulanceMap extends StatefulWidget {
  const AmbulanceMap({super.key});

  @override
  State<AmbulanceMap> createState() => _AmbulanceMapState();
}

class _AmbulanceMapState extends State<AmbulanceMap> {
  @override
  void initState() {
    super.initState();
    _getLocation.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _getLocation.getLocationStream(),
      builder: (context, AsyncSnapshot<Position> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          var postion = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  scrollGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    zoom: 12,
                    target: LatLng(
                      postion.latitude,
                      postion.longitude,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Database().deleteAlert(Authentication().id());
                    _patientHomeCtr.toggleAlert();
                  },
                  child: const Text("Remove alert"),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
