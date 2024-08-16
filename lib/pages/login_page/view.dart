import 'package:doctor_app_v2/pages/login_page/controller.dart';
import 'package:doctor_app_v2/pages/login_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: Get.height,
                child: Form(
                  key: controller.state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight(80.h),
                      kText(
                        text: 'Login Account',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                      kHeight(10.h),
                      kText(
                        text: 'Connect with your doctors today!',
                        fontSize: 20,
                      ),
                      kHeight(25.h),
                      LoginWidgets.kDivider(
                          direction: Axis.horizontal, number: 7),
                      kHeight(25.h),
                      LoginWidgets.kTextFormWithTitle(
                        title: 'Mobile Number',
                        context: context,
                        textController: controller.state.phoneNo,
                        hintText: 'Enter your mobile number',
                        type: "phone",
                      ),
                      kHeight(20.h),
                      LoginWidgets.kDivider(
                          direction: Axis.horizontal, number: 3),
                      LoginWidgets.kTextFormWithTitle(
                        title: 'Password',
                        context: context,
                        textController: controller.state.password,
                        hintText: 'Enter password',
                        type: "password",
                      ),
                      Spacer(),
                      LoginWidgets.kDivider(
                          direction: Axis.vertical, number: 5),
                      Spacer(),
                      kHeight(10.h),
                      LoginWidgets.kNextOrContinueButton(
                        text: 'Login',
                        onTap: () => controller.validateTextForms(
                            formkey: controller.state.formKey,
                            context: context),
                      ),
                      kHeight(10.h),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async =>
                              await Get.offAllNamed(ApprouteNames.signUpPage),
                          child: Text.rich(
                            TextSpan(
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: ColorConstants.darkGrey,
                              ),
                              children: [
                                TextSpan(text: "New to takeADoc? "),
                                TextSpan(
                                  text: "Sign Up",
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      kHeight(20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.state.isLoading.value,
              child: Container(
                height: Get.height,
                width: Get.width,
                color: ColorConstants.darkGrey.withOpacity(0.8),
                child: Align(
                  child: SizedBox(
                    height: 150.h,
                    width: 150.h,
                    child: const RiveAnimation.asset(
                      'assets/heart_rate_black (1).riv',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
