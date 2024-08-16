import 'package:get/get.dart';
import 'addmedicine_index.dart';


class AddMedicineBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AddMedicineController>(AddMedicineController());
  }
}
