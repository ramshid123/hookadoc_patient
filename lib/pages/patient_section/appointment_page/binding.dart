import 'package:get/get.dart';
import 'appointment_index.dart';


class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AppointmentController>(AppointmentController());
  }
}
