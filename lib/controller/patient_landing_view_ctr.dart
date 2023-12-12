import 'package:get/get.dart';

class PatientLandingViewCtr extends GetxController {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    update();
  }
}
