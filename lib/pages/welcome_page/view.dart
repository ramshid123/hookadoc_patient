import 'package:doctor_app_v2/pages/welcome_page/controller.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:rive/rive.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(
        child: LiquidSwipe(
          liquidController: controller.state.liquidController,
          disableUserGesture: true,
          // enableSideReveal: true,
          enableLoop: false,
          pages: [
            kPage1(controller),
            kPage2(controller),
            kPage3(controller),
          ],
        ),

        // child: PageView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   controller: controller.state.pageController,
        //   children: [
        //     kPage1(controller),
        //     kPage2(controller),
        //     kPage3(controller),
        //   ],
        // ),
      ),
    );
  }
}

Widget kPage1(WelcomeController controller) {
  return Obx(() {
    return AnimatedContainer(
      duration: 1000.ms,
      curve: Curves.easeInOut,
      color: controller.state.cont1Color.value,
      // color: ColorConstants.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          kHeight(10.h),
          // Spacer(),

          kIndicator(0),
          // kHeight(30.h),
          Spacer(),

          kText(
            text: 'Your well-being, our priority',
            color: ColorConstants.darkGrey,
            fontWeight: FontWeight.w500,
            fontSize: 35,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          kHeight(20.h),
          // Spacer(),

          kText(
            text:
                'Easily set reminders and stay on top of your medication schedule.',
            color: ColorConstants.mediumGreyH,
            fontSize: 20,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
          // kHeight(20.h),
          Spacer(),

          SizedBox(
            height: 130.h,
            child: RiveAnimation.asset(
              'assets/animations/medicine_anim.riv',
              onInit: (artboard) {
                final riveController = StateMachineController.fromArtboard(
                    artboard, 'State Machine 1');
                artboard.addController(riveController!);
                controller.state.anim1Trigger =
                    riveController.findSMI('canStart') as SMIInput;
              },
            ),
          ),
          Spacer(),
          // Image.asset(
          //   'assets/phone_call.png',
          //   height: 240.h,
          //   width: Get.width,
          // ),
          // kHeight(60.h),
          GestureDetector(
            onTap: () async => await controller.animatePage(1),
            child: Container(
              // height: 70.h,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 13.h),
              decoration: BoxDecoration(
                color: ColorConstants.darkGrey,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: kText(
                  text: 'Continue',
                  color: ColorConstants.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]
            .animate(interval: 200.ms)
            .moveY(
              begin: 20.h,
              duration: 400.ms,
              curve: Curves.easeInOut,
            )
            .fadeIn(
              duration: 400.ms,
              curve: Curves.easeInOut,
            ),
      ),
    );
  });
}

Widget kPage2(WelcomeController controller) {
  return Obx(() {
    return AnimatedContainer(
      duration: 1000.ms,
      curve: Curves.easeInOut,
      color: controller.state.cont2Color.value,
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          kHeight(10.h),
          kIndicator(1),
          // kHeight(50.h),
          Spacer(),

          kText(
            text: 'Connecting You to Expert Care',
            color: ColorConstants.darkGrey,
            maxLines: 3,
            fontWeight: FontWeight.w500,
            fontSize: 35,
            textAlign: TextAlign.center,
          ),
          kHeight(20.h),
          kText(
            text:
                'Easily connect with doctors and healthcare professionals from the comfort of your home.',
            color: ColorConstants.mediumGreyH,
            fontSize: 20,
            textAlign: TextAlign.center,
            maxLines: 8,
          ),
          // kHeight(20.h),
          Spacer(),

          SizedBox(
            height: 170.h,
            child: RiveAnimation.asset(
              'assets/animations/hand_shake.riv',
              onInit: (artboard) {
                final riveController = StateMachineController.fromArtboard(
                    artboard, 'State Machine 1');
                artboard.addController(riveController!);
                controller.state.anim2Trigger =
                    riveController.findSMI('canStart') as SMIInput;
                controller.state.anim2Trigger.value = false;
              },
            ),
          ).animate().fadeIn(),
          const Spacer(),
          // Image.asset(
          //   'assets/map.png',
          //   height: 240.h,
          //   width: Get.width,
          // ),
          // kHeight(60.h),
          GestureDetector(
            onTap: () async => await controller.animatePage(2),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.darkGrey,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: kText(
                  text: 'Continue',
                  color: ColorConstants.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

Widget kPage3(WelcomeController controller) {
  return Obx(() {
    return AnimatedContainer(
      duration: 1000.ms,
      curve: Curves.easeInOut,
      color: controller.state.cont3Color.value,
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          kHeight(10.h),
          kIndicator(2),
          // kHeight(40.h),
          Spacer(),
          kText(
            text: 'Stay Informed, Stay Healthy',
            color: ColorConstants.darkGrey,
            fontWeight: FontWeight.w500,
            fontSize: 35,
            maxLines: 5,
            textAlign: TextAlign.center,
          ),
          kHeight(20.h),
          // Spacer(),

          kText(
            text: 'Explore the latest breakthroughs and news in healthcare.',
            color: ColorConstants.mediumGreyH,
            fontSize: 20,
            textAlign: TextAlign.center,
            maxLines: 10,
          ),
          // kHeight(30.h),
          Spacer(),

          SizedBox(
            height: 170.h,
            child: RiveAnimation.asset(
              'assets/animations/news_anim.riv',
              onInit: (artboard) {
                final riveController = StateMachineController.fromArtboard(
                    artboard, 'State Machine 1');
                artboard.addController(riveController!);
                controller.state.anim3Trigger =
                    riveController.findSMI('canStart') as SMIInput;
                controller.state.anim3Trigger.value = false;
              },
            ),
          ).animate().fadeIn(),
          const Spacer(),
          // Image.asset(
          //   'assets/doctor_patient.png',
          //   height: 190.h,
          //   width: Get.width,
          // ),
          // kHeight(50.h),
          GestureDetector(
            onTap: () async => await Get.offAllNamed(ApprouteNames.signUpPage),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: ColorConstants.darkGrey,
                  width: 5.h,
                ),
              ),
              child: Center(
                child: kText(
                  text: 'Sign Up',
                  color: ColorConstants.darkGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          kHeight(20.h),
          GestureDetector(
            onTap: () async => await Get.offAllNamed(ApprouteNames.loginPage),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              width: Get.width,
              decoration: BoxDecoration(
                  color: ColorConstants.darkGrey,
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: ColorConstants.whiteColor,
                    width: 5.w,
                  )),
              child: Center(
                child: kText(
                  text: 'Login',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

Widget kIndicator(int index) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 10.h,
        width: index == 0 ? 25.h : 10.h,
        decoration: BoxDecoration(
          color:
              index == 0 ? ColorConstants.darkGrey : ColorConstants.mediumGreyH,
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 10.h,
        width: index == 1 ? 25.h : 10.h,
        decoration: BoxDecoration(
          color:
              index == 1 ? ColorConstants.darkGrey : ColorConstants.mediumGreyH,
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 10.h,
        width: index == 2 ? 25.h : 10.h,
        decoration: BoxDecoration(
          color:
              index == 2 ? ColorConstants.darkGrey : ColorConstants.mediumGreyH,
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
    ],
  );
}
