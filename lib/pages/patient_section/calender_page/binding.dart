import 'package:get/get.dart';
import 'calender_index.dart';


class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CalenderController>(CalenderController());
  }
}
