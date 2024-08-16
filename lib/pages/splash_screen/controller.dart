import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/auth_service.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:get/get.dart';
import 'splashscreen_index.dart';

class SplashScreenController extends GetxController {
  SplashScreenController();
  final state = SplashScreenState();

  @override
  void onReady() async {
    // TODO: implement onReady
    await Future.delayed(3.seconds);
    await checkForUser();
    super.onReady();
  }

  Future checkForUser() async {
    final isFirstTime = await SharedPrefHelpers.getBoolValue(
        key: SharedPrefHelpers.isThisTheFirstTimeToThisApp);
    if (isFirstTime == null || isFirstTime == true) {
      await Get.offAllNamed(ApprouteNames.welcomePage);
      return;
    }

    final currentUser = AuthService.instance.currentUser;
    if (currentUser == null)
      await Get.offAllNamed(ApprouteNames.loginPage);
    else
      await Get.offAllNamed(ApprouteNames.homePage);
  }
}
