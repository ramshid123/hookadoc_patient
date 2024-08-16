import 'package:doctor_app_v2/pages/patient_section/calender_page/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/calender_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/common/bottom_nav_bar.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

class CalenderPage extends GetView<CalenderController> {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.offAllNamed(ApprouteNames.homePage),
      child: Scaffold(
        bottomNavigationBar: kBottomNavigationBar(index: 1),
        body: Column(
          children: [
            kHeight(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async =>
                            await Get.offAllNamed(ApprouteNames.homePage),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorConstants.darkGrey,
                          size: 35.r,
                        ),
                      ),
                      kText(
                        text: 'My Appointments',
                        color: ColorConstants.darkGrey,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(),
                    ],
                  ),
                  kHeight(30.h),
                  CalenderWidgets.scheduleOrHistorySelection(
                      controller: controller),
                ],
              ),
            ),
            kHeight(30.h),
            CalenderWidgets.datePicker(controller: controller),
            kHeight(30.h),
            GetBuilder(
                init: controller,
                builder: (controller) {
                  return Expanded(
                    child: FirestoreListView(
                      query: DatabaseService.takersCollection.where('uid',
                          isEqualTo: controller.state.userID.value),
                      itemBuilder: (context, doc) {
                        controller.state.schedules.value =
                            doc.data()['schedules'] == null
                                ? []
                                : doc.data()['schedules'].where((appointment) {
                                    DateTime appointmentDateTime =
                                        DateFormat('dd/MM/yyyy')
                                            .parse(appointment['date']);
                                    return appointmentDateTime.isSameDay(
                                        controller.state.selectedDate.value);
                                  }).toList();
                        return Wrap(
                          children: [
                            for (Map<String, dynamic> schedule
                                in controller.state.schedules)
                              CalenderWidgets.scheduleTile(schedule: schedule),
                          ],
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
