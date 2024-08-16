import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:get/get.dart';
import 'calender_index.dart';

class CalenderController extends GetxController {
  CalenderController();
  final state = CalenderState();

  @override
  void onReady() async {
    // TODO: implement onReady
    await getUserId();
    super.onReady();
  }

  Future getUserId() async {
    state.userID.value =
        (await SharedPrefHelpers.getValue(key: SharedPrefHelpers.uid))
            .toString();
    update();
  }
}
