import 'package:get/get.dart';
import 'bookingsuccess_index.dart';


class BookingSuccessBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<BookingSuccessController>(BookingSuccessController());
  }
}
