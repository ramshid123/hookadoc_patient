import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:rive/rive.dart';

class WelcomeState {
  PageController pageController = PageController();
  LiquidController liquidController = LiquidController();

  var cont1Color = ColorConstants.whiteColor.obs;
  var cont2Color = ColorConstants.darkGrey.obs;
  var cont3Color = ColorConstants.darkGrey.obs;

  late SMIInput anim1Trigger;
  late SMIInput anim2Trigger;
  late SMIInput anim3Trigger;
}
