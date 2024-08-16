import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:doctor_app_v2/pages/patient_section/map_page/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/mymedicines_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorMapWidgets {
  static Widget customDoctorMarker() {
    return Image.asset(
      'assets/icons/doctor_marker.png',
      height: 50.h,
      width: 50.h,
    );
  }

  static Widget customMyLocationMarker() {
    return Image.asset(
      'assets/icons/my_location.png',
      height: 40.h,
      width: 40.h,
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

  static Widget radiusCard(
      {required bool isSelected,
      required int value,
      required DoctorMapController controller}) {
    return GestureDetector(
      onTap: () => controller.state.selectedRadius.value =
          double.parse(value.toString()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(
          color:
              isSelected ? ColorConstants.darkGrey : ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: kText(
          text: '$value KM',
          fontSize: 17,
          color:
              isSelected ? ColorConstants.whiteColor : ColorConstants.darkGrey,
        ),
      ),
    );
  }

  static Widget filterSubmitButton({required DoctorMapController controller}) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          await controller.fetchDoctorsInRadius();
          Get.back();
        },
        child: Container(
          height: 50.h,
          width: 200.w,
          decoration: BoxDecoration(
            color: ColorConstants.darkGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Align(
            alignment: Alignment.center,
            child: kText(
              text: 'Show me',
              fontSize: 20,
              color: ColorConstants.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  static Widget filterBottomSheet({required DoctorMapController controller}) {
    return Container(
      margin:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 300.h, bottom: 20.h),
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorConstants.darkGrey,
          width: 5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight(20.h),
          Align(
            alignment: Alignment.center,
            child: kText(
              text: 'Filter by',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          kHeight(30.h),
          kText(
            text: 'Category',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorConstants.mediumGreyH,
          ).paddingOnly(left: 20.w),
          kHeight(10.h),
          Container(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) =>
                  DoctorMapWidgets.doctorCategoryCard(
                      isSelected: index == 1, text: 'Cardiologist'),
            ),
          ),
          kHeight(50.h),
          kText(
            text: 'Radius',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorConstants.mediumGreyH,
          ).paddingOnly(left: 20.w),
          kHeight(10.h),
          Container(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) =>
                  Obx(() => DoctorMapWidgets.radiusCard(
                        isSelected:
                            controller.state.selectedRadius.value == index + 1,
                        value: index + 1,
                        controller: controller,
                      )),
            ),
          ),
          kHeight(50.h),
          DoctorMapWidgets.filterSubmitButton(controller: controller),
        ],
      ),
    );
  }
}

class TemporaryContainer extends StatelessWidget {
  final DoctorMapController controller;
  final String name;
  final List<dynamic> qualifications;
  final String category;
  final String fee;
  final String docId;
  final LatLng latlong;
  final String imageUrl;
  final String rating;
  const TemporaryContainer(
      {super.key,
      required this.controller,
      required this.name,
      required this.qualifications,
      required this.latlong,
      required this.docId,
      required this.fee,
      required this.category,
      required this.imageUrl,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
          // height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: ColorConstants.darkGrey,
              width: 5.w,
            ),
          ),
          child: Column(
            children: [
              kHeight(5.h),
              Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: ColorConstants.darkGrey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              kHeight(15.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1.h),
                    height: 65.h,
                    width: 65.h,
                    decoration: BoxDecoration(
                      color: ColorConstants.mediumGreyL,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: ColorConstants.darkGrey,
                        width: 1.w,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        imageUrl,
                        height: 50.h,
                        width: 50.h,
                        fit: BoxFit.fill,
                      ),
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
                      kHeight(5.h),
                      kText(
                        text: category,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.mediumGreyH,
                      )
                    ],
                  )
                ],
              ),
              kHeight(20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: ColorConstants.lightGrey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: ColorConstants.mediumGreyH,
                      size: 30.r,
                    ),
                    kWidth(5.w),
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
                            TextSpan(text: ' $qualification '),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              kHeight(20.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          color: ColorConstants.mediumGreyH,
                          size: 30.r,
                        ),
                        kWidth(5.w),
                        kText(
                          text: '$fee ₹',
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.mediumGreyH,
                        ),
                      ],
                    ),
                  ),
                  kWidth(20.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20.r,
                          color: ColorConstants.mediumGreyH,
                        ),
                        kWidth(5.w),
                        kText(
                          text: rating,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.mediumGreyH,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              kHeight(20.h),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async => await Get.toNamed(
                    ApprouteNames.doctorProfilePage,
                    arguments: docId),
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 0.w, bottom: 20.h),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.darkGrey,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'View',
                      color: ColorConstants.whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async => await launchUrl(Uri.parse(
                  'https://www.google.com/maps/dir/?api=1&destination=${latlong.latitude},${latlong.longitude}')),
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 20.w, bottom: 20.h),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                height: 52.h,
                width: 65.w,
                decoration: BoxDecoration(
                  color: ColorConstants.darkGrey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions,
                    color: ColorConstants.whiteColor,
                    size: 40.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
