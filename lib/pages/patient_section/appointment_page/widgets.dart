import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app_v2/pages/patient_section/appointment_page/appointment_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
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

class AppointmentWidgets {
  static Widget selectMorningOrEvening(
      {required AppointmentController controller}) {
    return Obx(() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.state.morningOrEveningSelection.value = 0;
              controller.update();
            },
            child: Container(
              width: Get.width / 2 - 20.w,
              height: 50.h,
              color: controller.state.morningOrEveningSelection.value == 0
                  ? ColorConstants.darkGrey
                  : ColorConstants.mediumGreyH,
              child: Center(
                child: kText(
                  text: 'Forenoon',
                  fontSize: 20,
                  fontWeight:
                      controller.state.morningOrEveningSelection.value == 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                  color: ColorConstants.whiteColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.state.morningOrEveningSelection.value = 1;
              controller.update();
            },
            child: Container(
              width: Get.width / 2 - 20.w,
              height: 50.h,
              color: controller.state.morningOrEveningSelection.value == 1
                  ? ColorConstants.darkGrey
                  : ColorConstants.mediumGreyH,
              child: Center(
                child: kText(
                  text: 'Afternoon',
                  fontSize: 20,
                  fontWeight:
                      controller.state.morningOrEveningSelection.value == 1
                          ? FontWeight.w500
                          : FontWeight.normal,
                  color: ColorConstants.whiteColor,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  static Widget timeTile(
      {required Map time, required AppointmentController controller}) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (time['avail']) {
            controller.state.selectedTime.value =
                '${controller.state.selectedDate.value}#${time['time']}';
          }
        },
        child: Container(
          height: 40.h,
          width: 80.w,
          decoration: BoxDecoration(
            color: controller.state.selectedTime.value ==
                    '${controller.state.selectedDate.value}#${time['time'] ?? ''}'
                ? ColorConstants.darkGrey
                : (time['avail'] ?? false
                    ? ColorConstants.lightGrey
                    : ColorConstants.mediumGreyL),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: kText(
              text: time['time'] ?? '',
              color: controller.state.selectedTime.value ==
                      '${controller.state.selectedDate.value}#${time['time'] ?? ''}'
                  ? ColorConstants.whiteColor
                  : (time['avail'] ?? false
                      ? ColorConstants.darkGrey
                      : ColorConstants.lightGrey),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  static Widget bookNowButton({required AppointmentController controller}) {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          // controller.proceedToPayment();
          controller.proceedToPayment();
          // await Get.toNamed(ApprouteNames., arguments: {
          //   'date': controller.state.selectedDate.value,
          //   'time': controller.state.selectedTime.value,
          //   'name': controller.state.name.value,
          //   'doc_id': 'a',
          // });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: 50.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: ColorConstants.darkGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: kText(
              text: 'Book Now',
              color: controller.state.selectedTime.value.isNotEmpty
                  ? ColorConstants.whiteColor
                  : ColorConstants.mediumGreyH,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
    });
  }

  static Widget customDatePicker(
      {required AppointmentController controller, required String title}) {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: kText(
                text: title,
                color: ColorConstants.darkGrey,
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          kHeight(10.h),
          SizedBox(
            // color: Colors.red,
            height: 80.h,
            width: Get.width,
            child: controller.state.selectedDate.value == null ||
                    controller.state.selectedDate.value!
                            .difference(DateTime.now()) >
                        Duration(days: 30)
                ? Center(
                    child: kText(text: 'No dates are available'),
                  )
                : FirestoreListView(
                    scrollDirection: Axis.horizontal,
                    query: DatabaseService.doctorsCollection
                        .where('id', isEqualTo: Get.arguments),
                    itemBuilder: (context, doc) {
                      // controller.getAvailableNumOfDates();
                      return SizedBox(
                        height: 80.h,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var date in controller.state.availableDates)
                              GestureDetector(
                                onTap: () {
                                  controller.state.selectedDate.value =
                                      DateFormat('dd/MM/yyyy')
                                          .parse(date['date']);
                                  controller.update();
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  height: 80.h,
                                  width: 65.w,
                                  decoration: BoxDecoration(
                                    color: DateFormat('dd/MM/yyyy')
                                                .parse(date['date']) ==
                                            controller.state.selectedDate.value!
                                        ? ColorConstants.darkGrey
                                        : ColorConstants.lightGrey,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      kText(
                                        text: DateFormat('MMM').format(
                                            DateFormat('dd/MM/yyyy')
                                                .parse(date['date'])),
                                        fontSize: 11,
                                        color: DateFormat('dd/MM/yyyy')
                                                    .parse(date['date']) ==
                                                controller
                                                    .state.selectedDate.value!
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.darkGrey,
                                      ),
                                      kText(
                                        text: DateFormat('dd').format(
                                            DateFormat('dd/MM/yyyy')
                                                .parse(date['date'])),
                                        fontSize: 22,
                                        color: DateFormat('dd/MM/yyyy')
                                                    .parse(date['date']) ==
                                                controller
                                                    .state.selectedDate.value!
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.darkGrey,
                                      ),
                                      kText(
                                        text: DateFormat('E').format(
                                            DateFormat('dd/MM/yyyy')
                                                .parse(date['date'])),
                                        fontSize: 13,
                                        color: DateFormat('dd/MM/yyyy')
                                                    .parse(date['date']) ==
                                                controller
                                                    .state.selectedDate.value!
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.darkGrey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        // child: ListView.builder(
                        //   shrinkWrap: true,
                        //   scrollDirection: Axis.horizontal,
                        //   // itemCount: 1,
                        //   itemCount: controller.state.numOfDatesAvailable.value,
                        //   itemBuilder: (context, index) {
                        //     return Container(
                        //         margin: EdgeInsets.symmetric(horizontal: 10.w),
                        //         height: 80.h,
                        //         width: 65.w,
                        //         decoration: BoxDecoration(
                        //           color: controller.state.selectedDate.value! ==
                        //                   DateFormat('dd/MM/yyyy').parse(
                        //                       doc.data()['timing'][index]['date'])
                        //               ? ColorConstants.darkGrey
                        //               : ColorConstants.lightGrey,
                        //           borderRadius: BorderRadius.circular(5.r),
                        //         ),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             kText(
                        //               text: DateFormat('MMM').format(
                        //                   DateFormat('dd/MM/yyyy').parse(
                        //                       doc.data()['timing'][index]['date'])),
                        //               fontSize: 11,
                        //               color: controller.state.selectedDate.value! ==
                        //                       DateFormat('dd/MM/yyyy').parse(
                        //                           doc.data()['timing'][index]['date'])
                        //                   ? ColorConstants.whiteColor
                        //                   : ColorConstants.darkGrey,
                        //             ),
                        //             kText(
                        //               text: DateFormat('dd').format(
                        //                   DateFormat('dd/MM/yyyy').parse(
                        //                       doc.data()['timing'][index]['date'])),
                        //               fontSize: 22,
                        //               color: controller.state.selectedDate.value! ==
                        //                       DateFormat('dd/MM/yyyy').parse(
                        //                           doc.data()['timing'][index]['date'])
                        //                   ? ColorConstants.whiteColor
                        //                   : ColorConstants.darkGrey,
                        //             ),
                        //             kText(
                        //               text: DateFormat('E').format(
                        //                   DateFormat('dd/MM/yyyy').parse(
                        //                       doc.data()['timing'][index]['date'])),
                        //               fontSize: 13,
                        //               color: controller.state.selectedDate.value! ==
                        //                       DateFormat('dd/MM/yyyy').parse(
                        //                           doc.data()['timing'][index]['date'])
                        //                   ? ColorConstants.whiteColor
                        //                   : ColorConstants.darkGrey,
                        //             ),
                        //           ],
                        //         ));
                        //   },
                        // ),
                      );
                    },
                  ),
            // child: DatePicker(
            //   DateTime.now(),
            //   daysCount: controller.state.numOfDatesAvailable.value,
            //   monthTextStyle: GoogleFonts.getFont(
            //     'Poppins',
            //     fontSize: 11.sp,
            //     fontWeight: FontWeight.normal,
            //     color: ColorConstants.darkGrey,
            //   ),
            //   dayTextStyle: GoogleFonts.getFont(
            //     'Poppins',
            //     fontSize: 13.sp,
            //     fontWeight: FontWeight.normal,
            //     color: ColorConstants.darkGrey,
            //   ),
            //   dateTextStyle: GoogleFonts.getFont(
            //     'Poppins',
            //     fontSize: 22.sp,
            //     fontWeight: FontWeight.normal,
            //     color: ColorConstants.darkGrey,
            //   ),
            //   selectionColor: ColorConstants.darkGrey,
            //   selectedTextColor: ColorConstants.whiteColor,
            //   initialSelectedDate: controller.state.selectedDate.value,
            //   onDateChange: (date) {
            //     controller.state.selectedDate.value = date;
            //     controller.update();
            //   },
            // ),
          ),
        ],
      );
    });
  }
}
