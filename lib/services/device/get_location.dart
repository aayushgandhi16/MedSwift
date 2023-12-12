import 'package:geolocator/geolocator.dart';

class GetLocation {
  Future checkPermission() async {
    final status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  Future<Position> getCurrentUserPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream();
  }
}
