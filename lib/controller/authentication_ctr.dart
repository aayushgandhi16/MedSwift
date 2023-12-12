// ignore_for_file: file_names, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medswift/models/user_model.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/services/firebase/database.dart';

class AuthCtr extends GetxController {
  final _authentication = Authentication();
  final _database = Database();

  Stream<User?> get getUserChanges => _authentication.getUserChanges;

  UserModel? _userData;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _age = TextEditingController();
  final _insurances = TextEditingController();
  final _address = TextEditingController();
  final _diseases = TextEditingController();
  final _currentMedication = TextEditingController();
  String _bloodGroup = "O+ve";
  String _gender = "Male";

  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get name => _name;
  TextEditingController get height => _height;
  TextEditingController get weight => _weight;
  TextEditingController get age => _age;
  TextEditingController get insurances => _insurances;
  TextEditingController get address => _address;
  TextEditingController get diseases => _diseases;
  TextEditingController get currentMedication => _currentMedication;
  String get bloodGroup => _bloodGroup;
  String get gender => _gender;
  UserModel? get userData => _userData;

  Future setUserData() async {
    String id = _authentication.id();
    var data = await _database.readUserData(id);
    _userData = data;
    update();
  }

  void setGender(String value) {
    _gender = value;
    update();
  }

  void setBloodGroup(String value) {
    _bloodGroup = value;
    update();
  }

  Future<UserModel?> isUserCreated(String id) async {
    final user = await _database.readUserData(id);
    return user;
  }

  Future signInUsingEmailAndPassword() async {
    await _authentication
        .signInUsingEmailAndPassword(
          _email.text,
          _password.text,
        )
        .then((value) => clear());
  }

  Future signUpUsingEmailAndPassword() async {
    await _authentication
        .signUpUsingEmailAndPassword(
          _email.text,
          _password.text,
        )
        .then((value) => clear());
  }

  Future signInWithGoogle() async {
    await _authentication.sigInWithGoogle().then((value) => clear());
  }

  Future createUser() async {
    final id = _authentication.id();
    final email = _authentication.email();
    await _database
        .createUserData(
      UserModel(
        id: id,
        name: _name.text,
        role: "PATIENT",
        email: email ?? "",
        bloodGroup: _bloodGroup,
        age: int.parse(_age.text),
        height: double.parse(_height.text),
        weight: double.parse(_weight.text),
        address: _address.text,
        insurances: _insurances.text,
        diseases: _diseases.text,
        currentMedications: _currentMedication.text,
      ),
    )
        .then(
      (value) {
        _name.clear();
        _bloodGroup = "O+ve";
        _age.clear();
        _height.clear();
        _weight.clear();
        _address.clear();
        _insurances.clear();
        _diseases.clear();
        _currentMedication.clear();
      },
    );
  }

  clear() {
    _email.clear();
    _password.clear();
  }
}
