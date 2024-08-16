import 'package:doctor_app_v2/pages/patient_section/calender_page/controller.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

class CalenderWidgets {
  static Widget scheduleOrHistorySelection(
      {required CalenderController controller}) {
    return Obx(() {
      return Container(
        height: 35.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  controller.state.scheduledOrHistory.value = 0;
                  controller.state.selectedDate.value =
                      DateTime.now().add(Duration(days: 365));
                  controller.update();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 25.h,
                  // width: Get.width,
                  decoration: BoxDecoration(
                    color: controller.state.scheduledOrHistory.value == 0
                        ? ColorConstants.whiteColor
                        : ColorConstants.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'Scheduled',
                      color: controller.state.scheduledOrHistory.value == 0
                          ? ColorConstants.darkGrey
                          : ColorConstants.mediumGreyH,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  controller.state.scheduledOrHistory.value = 1;
                  controller.state.selectedDate.value =
                      DateTime.now().add(Duration(days: 365));
                  controller.update();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 25.h,
                  // width: Get.width,
                  decoration: BoxDecoration(
                    color: controller.state.scheduledOrHistory.value == 1
                        ? ColorConstants.whiteColor
                        : ColorConstants.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'History',
                      color: controller.state.scheduledOrHistory.value == 1
                          ? ColorConstants.darkGrey
                          : ColorConstants.mediumGreyH,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  static Widget scheduleTile({required Map<String, dynamic> schedule}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                    text: schedule['doc_name'],
                    // text: 'Doctor Name',
                    // text: controller.state.schedule['doc_name'] ?? '_',
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
                          // for (var qualification in ['MBBS', 'FCSP'])
                          for (var qualification in schedule['qualifications'])
                            TextSpan(text: '$qualification '),
                          TextSpan(
                            text: '(${schedule['category'] ?? '_'})',
                          ),
                        ]),
                  ),
                ],
              )
            ],
          ),
          //schedule section
          kHeight(10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                  text: schedule['date'] == '_'
                      ? ''
                      : DateFormat('EEEE, MMMM dd').format(
                          DateFormat('dd/MM/yyyy').parse(schedule['date'])),
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
                  text: schedule['time'] ?? '_',
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
  }

  static Widget dateTile(
      {required CalenderController controller, required DateTime date}) {
    return GestureDetector(
      onTap: () {
        controller.state.selectedDate.value = date;
        controller.update();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        height: 80.h,
        width: 65.w,
        decoration: BoxDecoration(
          color: date == controller.state.selectedDate.value
              ? ColorConstants.darkGrey
              : ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            kText(
              // text: 'Oct',
              text: DateFormat('MMM').format(date),
              fontSize: 11,
              color: date == controller.state.selectedDate.value
                  ? ColorConstants.whiteColor
                  : ColorConstants.darkGrey,
            ),
            kText(
              // text: '28',
              text: DateFormat('dd').format(date),
              fontSize: 22,
              color: date == controller.state.selectedDate.value
                  ? ColorConstants.whiteColor
                  : ColorConstants.darkGrey,
            ),
            kText(
              // text: 'Tue',
              text: DateFormat('E').format(date),
              fontSize: 13,
              color: date == controller.state.selectedDate.value
                  ? ColorConstants.whiteColor
                  : ColorConstants.darkGrey,
            ),
          ],
        ),
      ),
    );
  }

  static Widget datePicker({required CalenderController controller}) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return SizedBox(
            height: 80.h,
            child: FirestoreListView(
                query: DatabaseService.takersCollection
                    .where('uid', isEqualTo: controller.state.userID.value),
                itemBuilder: (context, doc) {
                  var dateList = controller.state.scheduledOrHistory.value == 0
                      ? (doc.data()['schedules'] == null
                          ? []
                          : doc
                              .data()['schedules']
                              .where((appointment) {
                                DateTime appointmentDateTime =
                                    DateFormat('dd/MM/yyyy hh:mm a').parse(
                                        appointment['date'] +
                                            ' ' +
                                            appointment['time']);
                                return appointmentDateTime
                                    .isAfter(DateTime.now());
                              })
                              .toSet()
                              .toList())
                      : (doc.data()['schedules'] == null
                          ? []
                          : doc
                              .data()['schedules']
                              .where((appointment) {
                                DateTime appointmentDateTime =
                                    DateFormat('dd/MM/yyyy hh:mm a').parse(
                                        appointment['date'] +
                                            ' ' +
                                            appointment['time']);
                                return appointmentDateTime
                                    .isBefore(DateTime.now());
                              })
                              .toSet()
                              .toList());
                  dateList = dateList
                      .map((element) => element['date'])
                      .toSet()
                      .toList();
                  // controller.state.selectedDate.value =
                  //     DateFormat('dd/MM/yyyy').parse(dateList[0]['date']);
                  return SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dateList.length,
                      itemBuilder: (context, index) {
                        return dateTile(
                            controller: controller,
                            date: DateFormat('dd/MM/yyyy')
                                .parse(dateList[index]));
                      },
                    ),
                  );
                }),
            // child: ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //     return dateTile(controller: controller);
            //   },
            // ),
          );
        });
  }
}
