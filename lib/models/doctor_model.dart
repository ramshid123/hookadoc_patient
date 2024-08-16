// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

class DoctorModel {
  String name;
  String userId;
  String password;
  String location;
  String phoneNumber;
  String biography;
  String appointmentFee;
  String rating;
  String patientsNumberExperience;
  List<String> availableTimeSlots;

  DoctorModel({
    required this.name,
    required this.userId,
    required this.password,
    required this.location,
    required this.appointmentFee,
    required this.phoneNumber,
    required this.biography,
    required this.rating,
    required this.patientsNumberExperience,
    required this.availableTimeSlots,
  });

  factory DoctorModel.fromRawJson(String str) =>
      DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        name: json["Name"],
        userId: json["UserID"],
        password: json["password"],
        appointmentFee: json["Appointment Fee"],
        location: json["Location"],
        phoneNumber: json["Phone number"],
        biography: json["Biography"],
        rating: json["Rating"],
        patientsNumberExperience: json["Patients number Experience"],
        availableTimeSlots:
            List<String>.from(json["available time slots"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userID": userId,
        "password": password,
        "location": location,
        "phoneNo": phoneNumber,
        "biography": biography,
        "rating": rating,
        "experience": patientsNumberExperience,
        "timeSlots": List<dynamic>.from(availableTimeSlots.map((x) => x)),
      };
}
