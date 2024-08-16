import 'package:doctor_app_v2/pages/patient_section/doctor_profile_page/doctorprofile_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorProfilePage extends GetView<DoctorProfileController> {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: Get.width,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color(0xFFbababa).withOpacity(1),
            offset: Offset(0, -3),
            blurRadius: 11,
            spreadRadius: -1,
          ),
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              kHeight(10.h),
              kText(
                text: 'Schedule',
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
              kHeight(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 4; i++)
                    kPreDateBox(
                        controller: controller,
                        index: i,
                        date: DateTime.now().add(Duration(days: i))),
                ],
              ),
              kHeight(20.h),
              GestureDetector(
                onTap: () async => await controller.razorPayMethod(),
                child: Container(
                  height: 60.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'Make an appointment',
                      color: Colors.white70,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              kHeight(10.h),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 100.h, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    'https://pngimg.com/uploads/doctor/doctor_PNG15959.png',
                    height: 340.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ).paddingOnly(top: 20.h),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    kHeight(20.h),
                    Icon(
                      Icons.navigate_before,
                      size: 40.r,
                      color: Colors.black,
                    ),
                    kHeight(30.h),
                    kText(
                      text: 'Dr. John Carter',
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    kHeight(10.h),
                    kText(
                      text: 'profession',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    kHeight(30.h),
                    kRatingBoxes(
                      icon: Icons.star,
                      iconColor: Colors.amber,
                      title: 'Rating',
                      data: '4.5 from 5',
                    ),
                    kHeight(20.h),
                    kRatingBoxes(
                      icon: Icons.people,
                      iconColor: Colors.blue[600]!,
                      title: 'Patient',
                      data: '130 +',
                    ),
                    kHeight(30.h),
                    kText(
                      text: 'Biography',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    kHeight(10.h),
                    kText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      maxLines: 5,
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                    kText(
                      text: 'Read more',
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget kRatingBoxes({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String data,
}) {
  return Row(
    children: [
      Container(
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7a7a7a).withOpacity(1),
              offset: Offset(-3, 3),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 40.r,
        ),
      ),
      kWidth(20.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey),
          kHeight(5.h),
          kText(
            text: data,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ],
      )
    ],
  );
}

Widget kPreDateBox({
  required int index,
  required DateTime date,
  required DoctorProfileController controller,
}) {
  return GestureDetector(
    onTap: () => index != 3
        ? controller.state.selectedDateIndex.value = index
        : Get.toNamed(ApprouteNames
            .homePage), // change the destination to the appointment page.
    child: Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          color: controller.state.selectedDateIndex.value == index
              ? Colors.blue[800]
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7a7a7a).withOpacity(1),
              offset: Offset(-3, 3),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: index == 3
            ? Icon(
                Icons.calendar_month_rounded,
                size: 30.r,
                color: controller.state.selectedDateIndex.value == index
                    ? Colors.white
                    : Colors.blueGrey,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  kText(
                    color: controller.state.selectedDateIndex.value == index
                        ? Colors.white
                        : Colors.blueGrey,
                    text: DateFormat.LLL().format(date),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  kHeight(5.h),
                  kText(
                    color: controller.state.selectedDateIndex.value == index
                        ? Colors.white
                        : Colors.black,
                    text: DateFormat.d().format(date),
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
      );
    }),
  );
}
