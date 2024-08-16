import 'package:get/get.dart';
import 'mymedicines_index.dart';


class MyMedicinesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<MyMedicinesController>(MyMedicinesController());
  }
}
