import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/widgets.dart';
import 'package:doctor_app_v2/services/hive_service.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'mymedicines_index.dart';

class MyMedicinesController extends GetxController {
  MyMedicinesController();
  final state = MyMedicinesState();

  @override
  void onInit() async {
    // TODO: implement onInit
    await getAllMedicines();
    super.onInit();
  }

  Future deleteMedicineByTime({required String id}) async {
    await HiveServices.deleteMedicineTime(id: id);
    await getAllMedicines();
    Get.back();
  }

  Future getAllMedicines() async {
    state.medicineList.clear();
    state.medicineList.value = await HiveServices.getMedicines();
    state.medicineList.sort((a, b) => a.pillName.compareTo(b.pillName));
    state.medicineList.refresh();
  }

  Future showMedicineDetails(
      {required BuildContext context, required MedicineModel medicine}) async {
    await showModalBottomSheet(
      context: context,
      barrierColor: ColorConstants.darkGrey.withOpacity(0.5),
      backgroundColor: ColorConstants.darkGrey.withOpacity(0),
      isScrollControlled: true,
      builder: (context) =>
          TemporaryContainer(medicine: medicine, controller: this),
    );
  }

  String convertDateRaw2Readable({required String rawDate}) {
    return DateFormat('dd MMMM, y').format(DateTime.parse(rawDate));
  }

  String calculateLastDate(
      {required String startDateString,
      required String amountString,
      required int numOfDose}) {
    final startDate = DateTime.parse(startDateString);
    final amount = int.parse(amountString);

    final remainingDays = amount / numOfDose;
    final endDate = startDate.add(Duration(days: remainingDays.ceil()));
    return DateFormat('dd MMMM, y').format(endDate);
  }

  String calculateInventory(
      {required String startDateString,
      required String amountString,
      required int numOfDose}) {
    final startDate = DateTime.parse(startDateString);
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final amount = int.parse(amountString);

    int daysElapsed = today.difference(startDate).inDays;
    int remainingPills = amount - (daysElapsed * numOfDose);

    return '$remainingPills/$amount';
  }

  String calculateDuration(
      {required String startDateString,
      required String amountString,
      required int numOfDose}) {
    final startDate = DateTime.parse(startDateString);
    final endDate = DateFormat('d MMMM, y').parse(calculateLastDate(
        startDateString: startDateString,
        amountString: amountString,
        numOfDose: numOfDose));

    Duration difference = endDate.difference(startDate);

    if (difference.inDays < 1) {
      return "${difference.inHours} hours";
    } else if (difference.inDays == 1) {
      return "1 day";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days";
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return "$weeks weeks";
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return "$months months";
    } else {
      int years = (difference.inDays / 365).floor();
      return "$years years";
    }
  }
}
