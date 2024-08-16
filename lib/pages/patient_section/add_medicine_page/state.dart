import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMedicineState {
  final pillNameCont = TextEditingController();
  final amountCont = TextEditingController();
  final descriptionCont = TextEditingController();
  final medicineFormCont = TextEditingController(text: 'Tablet');

  final formkey = GlobalKey<FormState>(debugLabel: 'add_medicine_formkey');

  RxList<String> timings = <String>[].obs;

  var isLoading = false.obs;

  final pillTypes = [
    {
      'name': 'Tablet',
      'path': 'assets/icons/tablet.svg',
    },
    {
      'name': 'Capsule',
      'path': 'assets/icons/capsule.svg',
    },
    {
      'name': 'Solution',
      'path': 'assets/icons/solution.svg',
    },
    {
      'name': 'Injection',
      'path': 'assets/icons/injection.svg',
    },
    {
      'name': 'Inhaler',
      'path': 'assets/icons/inhaler.svg',
    },
    {
      'name': 'Drops',
      'path': 'assets/icons/drops.svg',
    },
    {
      'name': 'Others',
      'path': 'assets/icons/others.svg',
    },
  ];
}
