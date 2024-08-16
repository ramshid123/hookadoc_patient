import 'dart:ui';

import 'package:doctor_app_v2/pages/patient_section/doctor_profile_page/doctorprofile_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoctorProfilePage extends GetView<DoctorProfileController> {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: 80.h,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [ColorConstants.mediumGreyL, Colors.transparent],
        //         begin: AlignmentDirectional.bottomCenter,
        //         end: AlignmentDirectional.topCenter)),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Align(
              child: GestureDetector(
                onTap: () async => await Get.toNamed(
                    ApprouteNames.appointmentPage,
                    arguments: Get.arguments),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.darkGrey,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'Book Now',
                      color: ColorConstants.whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        return controller.state.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight(30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorConstants.darkGrey,
                            size: 35.r,
                          ),
                        ),
                        kText(
                          text: 'Information',
                          color: ColorConstants.darkGrey,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight(20.h),
                            Row(
                              children: [
                                //photo
                                Container(
                                  height: 90.h,
                                  width: 90.h,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.lightGrey,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Image.network(
                                      controller.state.profileImageUrl.value,
                                      height: 85.h,
                                      width: 85.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                kWidth(20.w),
                                //details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kText(
                                      text: controller.state.name.value,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.darkGrey,
                                    ),
                                    kHeight(5.h),
                                    Text.rich(
                                      TextSpan(
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: ColorConstants.mediumGreyH,
                                          ),
                                          children: [
                                            for (var item in controller
                                                .state.qualifications)
                                              TextSpan(text: '$item  '),
                                          ]),
                                    ),
                                    kHeight(5.h),
                                    // kText(
                                    //   text: 'MBBS',
                                    //   fontSize: 16,
                                    //   color: ColorConstants.mediumGreyH,
                                    // ),
                                    kText(
                                      text: controller.state.category.value,
                                      fontSize: 16,
                                      color: ColorConstants.mediumGreyH,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kHeight(20.h),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.lightGrey,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kText(
                                        text: 'Consultation Fee',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.mediumGreyH,
                                      ),
                                      kText(
                                        text: '₹${controller.state.fee.value}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.darkGrey,
                                      ),
                                    ],
                                  ),
                                ),
                                kWidth(20.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorConstants.mediumGreyH,
                                          size: 20.r,
                                        ),
                                        kWidth(5.w),
                                        kText(
                                            text: controller.state.rating.value,
                                            color: ColorConstants.mediumGreyH)
                                      ],
                                    ),
                                    kHeight(5.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.personal_injury,
                                          color: ColorConstants.mediumGreyH,
                                          size: 20.r,
                                        ),
                                        kWidth(5.w),
                                        kText(
                                            text: '100+ Patients',
                                            color: ColorConstants.mediumGreyH)
                                      ],
                                    ),
                                    kHeight(5.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.reviews_rounded,
                                          color: ColorConstants.mediumGreyH,
                                          size: 20.r,
                                        ),
                                        kWidth(5.w),
                                        kText(
                                            text: '250 Reviews',
                                            color: ColorConstants.mediumGreyH)
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            kHeight(20.h),
                            kText(
                              text: 'About',
                              color: ColorConstants.darkGrey,
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                            ),
                            kHeight(10.h),
                            kText(
                              text: controller.state.about.value,
                              // "As a dedicated cardiologist, I bring a wealth of knowledge and a compassionate approach to every patient I serve. With a background in flutter development, Python, and JavaScript, I appreciate the precision and attention to detail required in both coding and cardiology. I stay at the forefront of the field, always utilizing the latest advancements and techniques to ensure the highest standard of care. Just as I seek optimal solutions in programming, I apply the same diligence in tailoring individualized treatment plans to address a range of cardiac concerns. My commitment extends beyond the clinic, as I'm deeply engaged in research to contribute to the ongoing progress in cardiac health. With a foundation in Kali Linux and Ubuntu, I bring a tech-savvy edge to my practice, ensuring that I'm well-equipped to navigate the complexities of modern healthcare. Rest assured, your cardiovascular well-being is in capable hands.",
                              color: ColorConstants.darkGrey,
                              maxLines: 100,
                              fontSize: 16,
                            ),
                            kHeight(80.h)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
