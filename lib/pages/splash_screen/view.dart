import 'package:doctor_app_v2/pages/splash_screen/controller.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mediumGreyH,
      body: Center(
        child: Image.asset(
          'assets/medi_icon.png',
          height: 200.h,
          width: 200.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
