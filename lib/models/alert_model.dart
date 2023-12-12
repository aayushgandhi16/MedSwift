import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AlertModel {
  double latitude;
  double longitude;
  String patientId;
  String patientName;
  String id;
  AlertModel({
    required this.latitude,
    required this.longitude,
    required this.patientId,
    required this.patientName,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'patientId': patientId,
      'patientName': patientName,
      'id': id,
    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      patientId: map['patientId'] as String,
      patientName: map['patientName'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertModel.fromJson(String source) =>
      AlertModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
