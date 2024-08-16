import 'package:get/get.dart';
import 'signup_index.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SignUpController>(SignUpController());
  }
}
