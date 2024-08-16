import 'package:get/get.dart';
import 'login_index.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LoginController>(LoginController());
  }
}
