// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NearByModel {
  String name;
  String latitude;
  String longitude;
  NearByModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory NearByModel.fromMap(Map<String, dynamic> map) {
    return NearByModel(
      name: map['name'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NearByModel.fromJson(String source) => NearByModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
