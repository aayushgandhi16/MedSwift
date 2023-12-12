import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/models/file_model.dart';
import 'package:medswift/models/report_model.dart';
import 'package:medswift/models/user_model.dart';
import 'package:medswift/services/device/pick_files.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:medswift/services/firebase/storage.dart';

class DoctorReportsCtr extends GetxController {
  final _database = Database();
  final _id = TextEditingController();
  final _dropDownValue = SingleValueDropDownController();
  final _pickFiles = PickFiles();
  final _storage = Storage();

  List<ReportModel>? _reports;
  UserModel? _patient;
  List<FileModel> selectedFiles = [];
  bool isUploading = false;

  TextEditingController get id => _id;
  List<ReportModel>? get reports => _reports;
  UserModel? get patient => _patient;
  SingleValueDropDownController get dropDownValue => _dropDownValue;

  Future selectFiles() async {
    var value = await _pickFiles.pickFiles();
    selectedFiles = value;
    update();
  }

  Future uploadFiles() async {
    if (_patient == null) {
      return;
    }
    final doctor = await _database.readUserData(Authentication().id());
    for (var file in selectedFiles) {
      await _storage.uploadReportToFirebase(
        file,
        doctor!,
        _patient!,
      );
    }
    update();
  }

  Future setInfo() async {
    final userData = await _database.readUserData(_id.text);
    final userReports = await _database.readListOfReports(_id.text);
    if (userData != null) {
      await _database.addToViewed(userData);
    }
    _id.text = userData!.id;
    _patient = userData;
    _reports = userReports;
    update();
  }

  Future setInfoBySearch(String id) async {
    final userData = await _database.readUserData(id);
    final userReports = await _database.readListOfReports(id);
    _id.text = userData!.id;
    _patient = userData;
    _reports = userReports;
    update();
  }

  Future<List<UserModel>> readAllViewed() async {
    final id = Authentication().id();
    return await _database.readAllViewed(id);
  }

  Future<List<UserModel>> readAllUsers() async {
    return await _database.readAllUserData();
  }

  Future<List<ReportModel>> readAllReports() async {
    return await _database.readAllReports();
  }

  clear() {
    _id.clear();
  }
}
