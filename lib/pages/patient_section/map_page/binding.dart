import 'package:get/get.dart';
import 'doctormap_index.dart';


class DoctorMapBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<DoctorMapController>(DoctorMapController());
  }
}
