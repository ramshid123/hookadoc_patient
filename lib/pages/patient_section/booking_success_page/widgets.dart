import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class BookingSuccessWidgets {
  static Widget successRiveAnim() {
    final containerHeight = 170.h;
    return Container(
      height: containerHeight,
      width: 200.w,
      color: ColorConstants.whiteColor,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          RiveAnimation.asset(
            'assets/others/success.riv',
            artboard: 'Success',
            onInit: (artboard) async {
              await Future.delayed(500.ms);
              final controller = StateMachineController.fromArtboard(
                  artboard, 'State Machine 1');
              artboard.addController(controller!);
            },
          ),
          Container(
            height: containerHeight * 0.2,
            width: Get.width,
            color: ColorConstants.whiteColor,
          ),
        ],
      ),
    ).animate().moveY(
          begin: 100.h,
          duration: 500.ms,
          delay: 3000.ms,
          curve: Curves.easeInOut,
        );
  }

  static Widget skyRiveAnim() {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: RiveAnimation.asset(
            'assets/others/sky.riv',
            fit: BoxFit.fill,
            artboard: 'mainArtboard',
            onInit: (artboard) {
              final controller = StateMachineController.fromArtboard(
                  artboard, 'State Machine 1');
              artboard.addController(controller!);
            },
          ),
        ).animate().fadeIn(duration: 2000.ms, curve: Curves.easeInOut),
        Container(
          height: 50.h,
          width: 100.w,
          color: ColorConstants.darkGrey,
        ),
      ],
    );
  }
}
