import 'package:get/get.dart';
import 'welcome_index.dart';


class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<WelcomeController>(WelcomeController());
  }
}
