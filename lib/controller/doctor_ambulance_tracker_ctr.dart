import 'package:get/get.dart';

class DoctorAmbTrackerCtr extends GetxController {
  double? _latitude;
  double? _longitude;

  setLatLng(double lat, double long) {
    _latitude = lat;
    _longitude = long;
    update();
  }
}
