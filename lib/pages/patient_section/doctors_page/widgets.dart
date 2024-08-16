import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsWidgets {
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
          await Get.toNamed(ApprouteNames.doctorProfilePage, arguments: docId),
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
                // kText(
                //   text: 'MBBS. FCSP (Pediatrics)',
                //   color: ColorConstants.mediumGreyH,
                //   fontSize: 17,
                //   fontWeight: FontWeight.w500,
                // ),
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

  static Widget doctorCategoryCard(
      {required bool isSelected, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.darkGrey : ColorConstants.lightGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: kText(
        text: text,
        fontSize: 17,
        color: isSelected ? ColorConstants.whiteColor : ColorConstants.darkGrey,
      ),
    );
  }
}
