import 'package:doctor_app_v2/pages/patient_section/home_page/home_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeWidgets {
  static Widget medicineCard({
    required String pillName,
    required String note,
    required String iconPath,
    required String amount,
    required String time,
  }) {
    return SizedBox(
      width: 250.w,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timer_sharp,
                  color: ColorConstants.mediumGreyH,
                  size: 20.r,
                ),
                kWidth(10.w),
                kText(
                  text: time,
                  color: ColorConstants.mediumGreyH,
                  fontSize: 15,
                ),
                kWidth(10.w),
                kText(
                  text: 'Upcoming',
                  color: ColorConstants.mediumGreyL,
                  fontSize: 14,
                ),
              ],
            ),
            kHeight(5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: ColorConstants.mediumGreyL,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 40.h,
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: const ColorFilter.mode(
                          ColorConstants.darkGrey, BlendMode.srcIn),
                      fit: BoxFit.contain,
                    ),
                  ),
                  kWidth(10.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kText(
                          maxLines: 1,
                          text: pillName,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        kText(
                          maxLines: 1,
                          text: note.isEmpty ? '$amount left' : note,
                          color: ColorConstants.mediumGreyH,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  kWidth(20.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget doctorCard({
    required String name,
    required List<dynamic> qualifications,
    required String category,
    required String imageUrl,
    required String rating,
    required String docId,
  }) {
    return GestureDetector(
      onTap: () async =>
          await Get.toNamed(ApprouteNames .doctorProfilePage, arguments: docId),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.mediumGreyL,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.person,
                color: ColorConstants.darkGrey,
                size: 90.r,
              ),
            ),
            kWidth(20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(
                  text: name,
                  color: ColorConstants.darkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.mediumGreyH,
                    ),
                    children: [
                      for (var qualification in qualifications)
                        TextSpan(text: '$qualification '),
                      TextSpan(text: '($category)')
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.r,
                      color: ColorConstants.mediumGreyL,
                    ),
                    kWidth(5.w),
                    kText(
                      text: '$rating  |  250 Reviews',
                      color: ColorConstants.mediumGreyH,
                      fontSize: 15,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget upcomingScheduleContainer(
      {required HomeController controller}) {
    return Obx(() {
      return controller.state.schedule.isEmpty
          ? kText(text: 'loading')
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              // height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.darkGrey,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  //profile section
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.lightGrey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 35.r,
                          color: ColorConstants.mediumGreyH,
                        ),
                      ),
                      kWidth(15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(
                            text: controller.state.schedule['doc_name'] ?? '_',
                            // text: 'Dr. Anna Baker',
                            fontSize: 18,
                            color: ColorConstants.whiteColor,
                          ),
                          Text.rich(
                            TextSpan(
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 13.sp,
                                  color: ColorConstants.whiteColor,
                                ),
                                children: [
                                  for (var qualification in controller
                                      .state.schedule['qualifications'])
                                    TextSpan(text: '$qualification '),
                                  TextSpan(
                                      text:
                                          '(${controller.state.schedule['category'] ?? '_'})'),
                                ]),
                          ),
                        ],
                      )
                    ],
                  ),
                  //schedule section
                  kHeight(10.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.mediumGreyH,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: ColorConstants.mediumGreyL,
                          size: 20.r,
                        ),
                        kWidth(5.w),
                        kText(
                          text: controller.state.schedule['date'] == '_'
                              ? ''
                              : DateFormat('EEEE, MMMM dd').format(
                                  DateFormat('dd/MM/yyyy').parse(
                                      controller.state.schedule['date'])),
                          // text: 'Tuesday, July 22',
                          color: ColorConstants.mediumGreyL,
                          fontSize: 14,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.timer_outlined,
                          color: ColorConstants.mediumGreyL,
                          size: 20.r,
                        ),
                        kWidth(5.w),
                        kText(
                          text: controller.state.schedule['time'] ?? '_',
                          // text: '11:00 AM',
                          color: ColorConstants.mediumGreyL,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
