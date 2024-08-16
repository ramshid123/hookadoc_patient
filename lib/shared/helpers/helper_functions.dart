import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class Helpers {
  static Future vibrate() async {
    if (await Vibration.hasVibrator() != null &&
        (await Vibration.hasVibrator())!) {
      Vibration.vibrate(
        amplitude: 1,
        duration: 50,
      );
    }
  }

  static Future showGetSnackbar(
      {required String title,
      required String message,
      required IconData icon}) async {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      icon: Icon(
        icon,
        color: ColorConstants.whiteColor,
      ),
      titleText: kText(
        maxLines: 3,
        text: title,
        fontSize: 18,
        color: ColorConstants.whiteColor,
        fontWeight: FontWeight.bold,
      ),
      messageText: kText(
        maxLines: 3,
        text: message,
        fontSize: 16,
        color: ColorConstants.whiteColor,
      ),
      duration: 3.seconds,
      backgroundColor: ColorConstants.darkGrey,
      snackPosition: SnackPosition.TOP,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      borderRadius: 20.r,
    ));
  }

  static Future showNormalSnackBar(
      {required BuildContext context,
      required String title,
      required IconData icon}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: ColorConstants.darkGrey,
        content: Row(
          children: [
            Icon(
              icon,
              color: ColorConstants.lightGrey,
              size: 20.r,
            ),
            kWidth(10.w),
            kText(
              text: title,
              fontSize: 18,
              color: ColorConstants.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
