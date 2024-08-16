import 'package:get/get.dart';
import 'chat_index.dart';


class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ChatController>(ChatController());
  }
}
