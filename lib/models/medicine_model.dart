import 'package:hive_flutter/hive_flutter.dart';
part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class MedicineModel {
  @HiveField(0)
  final String pillName;
  @HiveField(1)
  final String amount;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String medicineForm;
  @HiveField(4)
  final List timings;
  @HiveField(5)
  final String startDate;
  @HiveField(6)
  final String id;

  MedicineModel({
    required this.pillName,
    required this.amount,
    required this.description,
    required this.medicineForm,
    required this.timings,
    required this.startDate,
    required this.id,
  });

  // NOTE : Below methods are usable only when each item in List<MedicineModel> has only one time in it's timings attribute.

  DateTime getFirstTimingAsDateTime() {
    List<String> parts = timings[0].split(' ');
    List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    if (parts[1] == 'PM' && hour != 12) {
      hour += 12;
    }
    return DateTime(2023, 1, 1, hour, minute);
  }

  static int compareByFirstTiming(MedicineModel a, MedicineModel b) {
    DateTime aTime = a.getFirstTimingAsDateTime();
    DateTime bTime = b.getFirstTimingAsDateTime();
    return aTime.compareTo(bTime);
  }
}
