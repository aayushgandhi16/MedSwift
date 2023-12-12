import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PrescriptionModel {
  String id;
  String authorId;
  String authorName;
  String patientName;
  String patientId;
  String prescription;
  String timeStamp;
  PrescriptionModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.patientName,
    required this.patientId,
    required this.prescription,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'patientName': patientName,
      'patientId': patientId,
      'prescription': prescription,
      'timeStamp': timeStamp,
    };
  }

  factory PrescriptionModel.fromMap(Map<String, dynamic> map) {
    return PrescriptionModel(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      authorName: map['authorName'] as String,
      patientName: map['patientName'] as String,
      patientId: map['patientId'] as String,
      prescription: map['prescription'] as String,
      timeStamp: map['timeStamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrescriptionModel.fromJson(String source) =>
      PrescriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
