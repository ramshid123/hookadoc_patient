import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'welcome_index.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final state = WelcomeState();

  @override
  void onReady() async {
    // TODO: implement onReady
    await SharedPrefHelpers.setBoolValue(
        key: SharedPrefHelpers.isThisTheFirstTimeToThisApp, value: false);
    Future.delayed(1000.milliseconds, () => state.anim1Trigger.value = true);
    super.onReady();
  }

  Future animatePage(int index) async {
    await state.liquidController.animateToPage(page: index, duration: 800);
    await Future.delayed(400.milliseconds);
    if (index == 1) {
      state.cont2Color.value = ColorConstants.whiteColor;
      await Future.delayed(2000.milliseconds);
      state.anim2Trigger.value = true;
    } else if (index == 2) {
      state.cont3Color.value = ColorConstants.whiteColor;
      await Future.delayed(2000.milliseconds);
      state.anim3Trigger.value = true;
      // await Future.delayed(
      //     2000.milliseconds, () => state.anim3Trigger.value = true);
    }
    // await Future.delayed(1500.milliseconds);
    // await state.pageController.animateToPage(index,
    //     duration: Duration(seconds: 1), curve: Curves.ease);
  }
}
