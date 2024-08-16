import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:get/get.dart';

class MyMedicinesState {
  RxList<MedicineModel> medicineList = <MedicineModel>[].obs;

  final iconMappingData = {
    'Tablet': 'assets/icons/tablet.svg',
    'Capsule': 'assets/icons/capsule.svg',
    'Solution': 'assets/icons/solution.svg',
    'Injection': 'assets/icons/injection.svg',
    'Inhaler': 'assets/icons/inhaler.svg',
    'Drops': 'assets/icons/drops.svg',
    'Others': 'assets/icons/others.svg',
  };
}
