// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

class PatientModel {
  String name;
  String userId;
  String password;
  String dob;
  String address;
  String phoneNo;

  PatientModel({
    required this.name,
    required this.userId,
    required this.password,
    required this.dob,
    required this.address,
    required this.phoneNo,
  });

  factory PatientModel.fromRawJson(String str) =>
      PatientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        name: json["name"],
        userId: json["userID"],
        password: json["password"],
        dob: json["DOB"],
        address: json["Address"],
        phoneNo: json["phoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userID": userId,
        "password": password,
        "DOB": dob,
        "Address": address,
        "phoneNo": phoneNo,
      };
}
