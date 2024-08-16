// To parse this JSON data, do
//
//     final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

class TimeSlotModel {
  TimeSlots timeSlots;

  TimeSlotModel({
    required this.timeSlots,
  });

  factory TimeSlotModel.fromRawJson(String str) =>
      TimeSlotModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        timeSlots: TimeSlots.fromJson(json["time_slots"]),
      );

  Map<String, dynamic> toJson() => {
        "time_slots": timeSlots.toJson(),
      };
}

class TimeSlots {
  List<String> sunday;
  List<String> saturday;
  List<String> tuesday;
  List<String> wednesday;
  List<String> thursday;
  List<String> friday;
  List<String> monday;

  TimeSlots({
    required this.sunday,
    required this.saturday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.monday,
  });

  factory TimeSlots.fromRawJson(String str) =>
      TimeSlots.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
        sunday: List<String>.from(json["sunday"].map((x) => x)),
        saturday: List<String>.from(json["saturday"].map((x) => x)),
        tuesday: List<String>.from(json["tuesday"].map((x) => x)),
        wednesday: List<String>.from(json["wednesday"].map((x) => x)),
        thursday: List<String>.from(json["thursday"].map((x) => x)),
        friday: List<String>.from(json["friday"].map((x) => x)),
        monday: List<String>.from(json["monday"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sunday": List<dynamic>.from(sunday.map((x) => x)),
        "saturday": List<dynamic>.from(saturday.map((x) => x)),
        "tuesday": List<dynamic>.from(tuesday.map((x) => x)),
        "wednesday": List<dynamic>.from(wednesday.map((x) => x)),
        "thursday": List<dynamic>.from(thursday.map((x) => x)),
        "friday": List<dynamic>.from(friday.map((x) => x)),
        "monday": List<dynamic>.from(monday.map((x) => x)),
      };
}
