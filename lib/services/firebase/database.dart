import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medswift/models/alert_model.dart';

import 'package:medswift/models/near_by_model.dart';
import 'package:medswift/models/prescription_model.dart';
import 'package:medswift/models/report_model.dart';
import 'package:medswift/models/user_model.dart';
import 'package:medswift/services/firebase/authentication.dart';

class Database {
  final _firestore = FirebaseFirestore.instance;

  // ===== User CRUD =====
  Future createUserData(UserModel user) async {
    await _firestore.collection("users").doc(user.id).set(user.toMap());
  }

  Future updateUserData(UserModel user) async {
    await _firestore.collection("users").doc(user.id).set(user.toMap());
  }

  Future<UserModel?> readUserData(String id) async {
    final value = await _firestore.collection("users").doc(id).get();
    if (value.exists) {
      return UserModel.fromMap(value.data()!);
    }
    return null;
  }

  Future<List<UserModel>> readAllUserData() async {
    final value = await _firestore.collection("users").get();
    return value.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future deleteUserData(String id) async {
    await _firestore.collection("users").doc(id).delete();
  }

  // ===== Reports CRUD =====
  Future createReport(ReportModel report) async {
    await _firestore.collection("reports").doc(report.id).set(report.toMap());
  }

  Future<List<ReportModel>> readListOfReports(String patientId) async {
    final data = await _firestore
        .collection("reports")
        .where("patientId", isEqualTo: patientId)
        .get();

    return data.docs.map((e) => ReportModel.fromMap(e.data())).toList();
  }

  Future<List<PrescriptionModel>> readListOfPrescriptions(String patientId) async {
    final data = await _firestore
        .collection("prescriptions")
        .where("patientId", isEqualTo: patientId)
        .get();

    return data.docs.map((e) => PrescriptionModel.fromMap(e.data())).toList();
  }

  Future<List<ReportModel>> readAllReports() async {
    final data = await _firestore.collection("reports").get();

    return data.docs.map((e) => ReportModel.fromMap(e.data())).toList();
  }

  Future readReport(String id) async {
    final data = await _firestore.collection("reports").doc(id).get();
    return ReportModel.fromMap(data.data()!);
  }

  Future updateReport(ReportModel report) async {
    await _firestore.collection("reports").doc(report.id).set(report.toMap());
  }

  Future deleteReport(String id) async {
    await _firestore.collection("reports").doc(id).delete();
  }

  // ===== Viewed CRUD =====
  Future addToViewed(UserModel user) async {
    final id = Authentication().id();
    await _firestore
        .collection("viewed")
        .doc(id)
        .collection("users")
        .doc(user.id)
        .set(user.toMap());
  }

  Future<List<UserModel>> readAllViewed(String id) async {
    final data = await _firestore.collection("viewed/$id/users").get();
    return data.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  Future createAlert(AlertModel alert) async {
    await _firestore.collection("alerts").doc(alert.id).set(alert.toMap());
  }

  Future deleteAlert(String id) async {
    await _firestore.collection("alerts").doc(id).delete();
  }

  //
  Future<List<NearByModel>> getNearByTestCenters() async {
    final data = await _firestore.collection("testCentres").get();
    return data.docs.map((e) => NearByModel.fromMap(e.data())).toList();
  }

  Future createPrescription(PrescriptionModel value) async {
    await _firestore
        .collection("prescriptions")
        .doc(value.id)
        .set(value.toMap());
  }

  Future<List<PrescriptionModel>> readPrescriptions(String id) async {
    final data = await _firestore
        .collection("prescriptions")
        .where("patientId", isEqualTo: id)
        .get();
    return data.docs
        .map((doc) => PrescriptionModel.fromMap(doc.data()))
        .toList();
  }
}
