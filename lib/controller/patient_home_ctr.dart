import 'package:get/get.dart';
import 'package:medswift/controller/authentication_ctr.dart';

import 'package:medswift/services/firebase/database.dart';
import 'package:uuid/uuid.dart';

class PatientHomeCtr extends GetxController {
  
  bool isAlerted = false;
 

  toggleAlert() async {
    isAlerted = !isAlerted;
    
    update();
  }

  
}
