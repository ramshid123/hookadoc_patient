import 'dart:io';

import 'package:doctor_app_v2/pages/sign_up_page/controller.dart';
import 'package:doctor_app_v2/pages/sign_up_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
// import 'package:zego_zimkit/compnents/messages/widgets/widgets.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onwillPopScope();
      },
      child: Obx(() {
        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              PageView(
                controller: controller.state.pageController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  kPage1(context),
                  kPage2(context),
                  kPage3(context),
                ],
              ),
              controller.state.isLoading.value
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      // margin: EdgeInsets.symmetric(
                      //     horizontal: 30.w, vertical: 100.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.w, vertical: 140.w),
                      color: ColorConstants.darkGrey.withOpacity(0.8),
                      child: const RiveAnimation.asset('assets/heart_rate.riv'),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }

  Widget kPage3(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: SingleChildScrollView(
          child: SizedBox(
        height: Get.height,
        child: Form(
          key: controller.state.formKey3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight(80.h),
              kText(
                text: 'Who am I?',
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
              kHeight(10.h),
              kText(
                text: 'Tell us about yourself.',
                fontSize: 20,
              ),
              kHeight(30.h),
              Align(
                alignment: Alignment.center,
                child: GetBuilder(
                    init: controller,
                    builder: (controller) {
                      return Container(
                        height: 200.h,
                        width: 200.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.darkGrey,
                          shape: BoxShape.circle,
                          image: controller.state.avatarPic != null
                              ? DecorationImage(
                                  image: FileImage(
                                      File(controller.state.avatarPic!.path)),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage('assets/unknown.png'),
                                ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            // final pickedImage = await ZIMKit().pickFiles(
                            //   allowMultiple: false,
                            //   type: FileType.image,
                            // );
                            controller.state.avatarPic = pickedImage;
                            controller.update();
                          },
                          child: controller.state.avatarPic == null
                              ? Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.blueGrey.withOpacity(0.8),
                                    size: 100.h,
                                  ),
                                )
                              : null,
                        ),
                      );
                    }),
              ),
              const Spacer(),
              Obx(() {
                return CheckboxListTile(
                  value: controller.state.isTermsAgreed.value,
                  onChanged: (v) => controller.state.isTermsAgreed.value = v!,
                  side: BorderSide(
                    width: 1,
                    color: Colors.blueGrey,
                  ),
                  title: kText(
                    text:
                        'I agree to the Terms and Conditions and confirm that I am 13 years old or above.',
                    maxLines: 5,
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                  fillColor: MaterialStatePropertyAll(Colors.blueGrey.shade300),
                  checkboxShape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                );
              }),
              kHeight(30.h),
              Obx(() {
                return SignUpWidgets.kNextOrContinueButton(
                  onTap: () => controller.validateTextForms(
                    formkey: controller.state.formKey3,
                    context: context,
                  ),
                  text: 'Continue',
                  color: controller.state.isTermsAgreed.value
                      ? ColorConstants.darkGrey!
                      : Colors.blueGrey.shade300,
                );
              }),
              kHeight(50.h),
            ],
          ),
        ),
      )),
    );
  }

  Widget kPage2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Form(
            key: controller.state.formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(80.h),
                kText(
                  text: 'Who am I?',
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
                kHeight(10.h),
                kText(
                  text: 'Tell us about yourself.',
                  fontSize: 20,
                ),
                kHeight(50.h),
                SignUpWidgets.kTextFormWithTitle(
                  title: 'Name',
                  textController: controller.state.name,
                  context: context,
                  hintText: 'Enter your name',
                  type: "text",
                ),
                kHeight(20.h),
                SignUpWidgets.kTextFormWithTitle(
                  title: 'Date of birth',
                  context: context,
                  textController: controller.state.dob,
                  controller: controller,
                  hintText: 'dd/mm/yyyy',
                  type: "date",
                ),
                kHeight(20.h),
                SignUpWidgets.kTextFormWithTitle(
                  title: 'Address',
                  context: context,
                  textController: controller.state.address,
                  hintText: 'Enter your address',
                  type: "address",
                ),
                Spacer(),
                SignUpWidgets.kDivider(direction: Axis.vertical, number: 3),
                Spacer(),
                SignUpWidgets.kNextOrContinueButton(
                  onTap: () => controller.validateTextForms(
                      formkey: controller.state.formKey2, context: context),
                  text: 'Next',
                ),
                kHeight(50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kPage1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          child: Form(
            key: controller.state.formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(80.h),
                kText(
                  text: 'Create Account',
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
                kHeight(10.h),
                kText(
                  text: 'Connect with your doctors today!',
                  fontSize: 20,
                ),
                kHeight(25.h),
                SignUpWidgets.kDivider(direction: Axis.horizontal, number: 7),
                kHeight(25.h),
                SignUpWidgets.kTextFormWithTitle(
                  title: 'Mobile Number',
                  context: context,
                  textController: controller.state.phoneNo,
                  hintText: 'Enter your mobile number',
                  type: "phone",
                ),
                kHeight(20.h),
                SignUpWidgets.kDivider(direction: Axis.horizontal, number: 3),
                SignUpWidgets.kTextFormWithTitle(
                  title: 'Password',
                  context: context,
                  textController: controller.state.password,
                  hintText: 'Enter password',
                  type: "password",
                ),
                Spacer(),
                SignUpWidgets.kDivider(direction: Axis.vertical, number: 5),
                Spacer(),
                kHeight(10.h),
                SignUpWidgets.kNextOrContinueButton(
                  text: 'Next',
                  onTap: () => controller.validateTextForms(
                      formkey: controller.state.formKey1, context: context),
                ),
                kHeight(10.h),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async =>
                        await Get.offAllNamed(ApprouteNames.loginPage),
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                          color: ColorConstants.darkGrey,
                        ),
                        children: [
                          TextSpan(text: "Already have one? "),
                          TextSpan(
                            text: "Login",
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
    );
  }
}
