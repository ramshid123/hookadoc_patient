import 'package:get/get.dart';
import 'doctorprofile_index.dart';


class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<DoctorProfileController>(DoctorProfileController());
  }
}
