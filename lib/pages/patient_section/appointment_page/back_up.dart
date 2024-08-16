import 'package:doctor_app_v2/pages/patient_section/appointment_page/appointment_index.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class AppointMentPage extends GetView<AppointmentController> {
  const AppointMentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: kBottomNavBar(),
                appBar: PreferredSize(
                  preferredSize: Size(Get.width, 70.h),
                  child: SizedBox(
                    height: 70.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.navigate_before,
                            color: Colors.black,
                          ),
                          iconSize: 40.r,
                        ),
                        kText(
                          text: 'Appointment',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          // dummy button. Do not need a onPressed(){} function.
                          onPressed: () {},
                          icon: Icon(
                            Icons.navigate_before,
                            color: Colors.transparent,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 40.r,
                        ),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kHeight(10.h),
                        Container(
                          height: 340.h,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(20.r)),
                          child: controller.state.calendarController == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ScrollableCleanCalendar(
                                  calendarController:
                                      controller.state.calendarController!,
                                  layout: Layout.DEFAULT,
                                ),
                        ),
                        kHeight(20.h),
                        kText(
                          text: 'Time',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ).paddingOnly(left: 10.w),
                        kHeight(20.h),
                        SizedBox(
                          width: Get.width,
                          height: 120.h,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 6; i++)
                                kTimeBox(
                                  index: i,
                                  controller: controller,
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}

Widget kTimeBox(
    {required AppointmentController controller, required int index}) {
  return GestureDetector(
    onTap: () => controller.state.selectedTimeBoxIndex.value = index,
    child: Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        height: 50.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: controller.state.selectedTimeBoxIndex.value == index
              ? Colors.blue[700]
              : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7a7a7a).withOpacity(1),
              offset: Offset(-3, 3),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: kText(
            text: '9:00 AM',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: controller.state.selectedTimeBoxIndex.value == index
                ? Colors.white
                : Colors.black,
          ),
        ),
      );
    }),
  );
}

Widget kBottomNavBar() {
  return Container(
    height: 70.h,
    width: Get.width,
    color: Colors.blue[800],
    child: Center(
      child: kText(
        text: 'Book an appointment',
        color: Colors.white70,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
