import 'package:doctor_app_v2/pages/patient_section/booking_success_page/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/booking_success_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:doctor_app_v2/shared/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';

class BookingSuccessPage extends GetView<BookingSuccessController> {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    return Scaffold(
      backgroundColor: ColorConstants.darkGrey,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            BookingSuccessWidgets.skyRiveAnim(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: 300.w,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  BookingSuccessWidgets.successRiveAnim(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kHeight(145.h),
                      kText(
                        text: 'Booking Successful',
                        fontSize: 24,
                        maxLines: 2,
                        fontWeight: FontWeight.bold,
                      ),
                      kHeight(10.h),
                      kText(
                        text:
                            'Your booking has beed successfully confirmed. We look forward to it.',
                        maxLines: 3,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                      kHeight(40.h),
                      GestureDetector(
                        onTap: () async {
                          await Helpers.vibrate();
                          Get.offAllNamed(ApprouteNames.homePage);
                        },
                        child: Container(
                          height: 50.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: ColorConstants.darkGrey,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: kText(
                              text: 'Thanks!',
                              color: ColorConstants.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      kHeight(20.h),
                    ]
                        .animate(interval: 300.ms)
                        .moveY(
                          begin: 10.h,
                          curve: Curves.easeInOut,
                          duration: 300.ms,
                          delay: 3500.ms,
                        )
                        .fadeIn(
                          curve: Curves.easeInOut,
                          duration: 300.ms,
                          delay: 3500.ms,
                        ),
                  ),
                ],
              ),
            ).animate().flipV(
                duration: 500.ms, curve: Curves.easeInOut, delay: 500.ms),
          ],
        ),
      ),
    );
  }
}
