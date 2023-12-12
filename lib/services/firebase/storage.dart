import 'package:firebase_storage/firebase_storage.dart';
import 'package:medswift/models/file_model.dart';
import 'package:medswift/models/report_model.dart';
import 'package:medswift/models/user_model.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:uuid/uuid.dart';

class Storage {
  final _firebaseStorage = FirebaseStorage.instance;
  final _database = Database();

  Future uploadReportToFirebase(
    FileModel model,
    UserModel doctor,
    UserModel patient,
  ) async {
    final ref = _firebaseStorage.ref(model.title);
    await ref.putData(model.data);
    var url = await ref.getDownloadURL();
    await _database.createReport(
      ReportModel(
        id: const Uuid().v4(),
        title: model.title,
        patientName: patient.name,
        patientId: patient.id,
        url: url,
        createdOn: DateTime.now().toIso8601String(),
        authorName: doctor.name,
        authorId: doctor.id,
      ),
    );
  }
}
