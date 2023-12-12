// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String bloodGroup;
  String role;
  int age;
  double height;
  double weight;
  String address;
  String? insurances;
  String? diseases;
  String? currentMedications;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bloodGroup,
    required this.role,
    required this.age,
    required this.height,
    required this.weight,
    required this.address,
    this.insurances,
    this.diseases,
    this.currentMedications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'bloodGroup': bloodGroup,
      'role': role,
      'age': age,
      'height': height,
      'weight': weight,
      'address': address,
      'insurances': insurances,
      'diseases': diseases,
      'currentMedications': currentMedications,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      bloodGroup: map['bloodGroup'] as String,
      role: map['role'] as String,
      age: map['age'] as int,
      height: map['height'] as double,
      weight: map['weight'] as double,
      address: map['address'] as String,
      insurances:
          map['insurances'] != null ? map['insurances'] as String : null,
      diseases: map['diseases'] != null ? map['diseases'] as String : null,
      currentMedications: map['currentMedications'] != null
          ? map['currentMedications'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
