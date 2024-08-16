import 'package:get/get.dart';
import 'doctors_index.dart';


class DoctorsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<DoctorsController>(DoctorsController());
  }
}
