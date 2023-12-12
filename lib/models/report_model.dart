// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportModel {
  String id;
  String title;
  String patientName;
  String patientId;
  String url;
  String createdOn;
  String authorName;
  String authorId;

  ReportModel({
    required this.id,
    required this.title,
    required this.patientName,
    required this.patientId,
    required this.url,
    required this.createdOn,
    required this.authorName,
    required this.authorId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'patientName': patientName,
      'patientId': patientId,
      'url': url,
      'createdOn': createdOn,
      'authorName': authorName,
      'authorId': authorId,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] as String,
      title: map['title'] as String,
      patientName: map['patientName'] as String,
      patientId: map['patientId'] as String,
      url: map['url'] as String,
      createdOn: map['createdOn'] as String,
      authorName: map['authorName'] as String,
      authorId: map['authorId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
