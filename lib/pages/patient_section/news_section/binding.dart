import 'package:get/get.dart';
import 'news_index.dart';


class NewsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<NewsController>(NewsController());
  }
}
