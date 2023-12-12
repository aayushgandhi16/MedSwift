import 'package:get/get.dart';

class DoctorLandingViewCtr extends GetxController{

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setScreen(int screenIndex){
    if(screenIndex == _currentIndex){
      return;
    }
    _currentIndex = screenIndex;
    update();
  }



}