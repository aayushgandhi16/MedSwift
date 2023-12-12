import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medswift/models/user_model.dart';

class SpeechToTextCtr extends GetxController {
  final speechToText = TextEditingController();
  UserModel? patient;

  setpatient(UserModel value) {
    patient = value;
    update();
  }
}
