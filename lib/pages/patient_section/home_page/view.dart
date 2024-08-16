import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/pages/patient_section/home_page/home_index.dart';
import 'package:doctor_app_v2/pages/patient_section/home_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/services/local_notification_service.dart';
import 'package:doctor_app_v2/shared/common/bottom_nav_bar.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.getUpcomingSchedule();
    return Scaffold(
      bottomNavigationBar: kBottomNavigationBar(index: 0),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await NotificationService().showNotification();
      }),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight(30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.grid_view_rounded,
                  color: ColorConstants.darkGrey,
                  size: 35.r,
                ),
                Icon(
                  Icons.search,
                  color: ColorConstants.darkGrey,
                  size: 35.r,
                ),
              ],
            ),
          ),
          kHeight(25.h),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: kText(
                    text: "Today's Medicines",
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kHeight(20.h),
                controller.state.medicineList.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 10.h),
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorConstants.mediumGreyL,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kText(
                              text: 'No Medicines for today..',
                              color: ColorConstants.mediumGreyH,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            kHeight(10.h),
                            GestureDetector(
                              onTap: () async => await Get.toNamed(
                                  ApprouteNames.addMedicinesPage),
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 40.r,
                                color: ColorConstants.mediumGreyH,
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 130.h,
                        // color: Colors.red,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.state.medicineList.length,
                          itemBuilder: (context, index) {
                            final medicineItem =
                                controller.state.medicineList[index];
                            return HomeWidgets.medicineCard(
                              pillName: medicineItem.pillName,
                              note: medicineItem.description,
                              iconPath: controller.state
                                  .iconMappingData[medicineItem.medicineForm]!,
                              amount: medicineItem.amount,
                              time: medicineItem.timings[0],
                            );
                          },
                        ),
                      ),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible: controller.state.schedule.isNotEmpty,

// https://pub.dev/packages/flutter_local_notifications#gradle-setup
// https://www.youtube.com/watch?v=SxCTpn5cTVQ&ab_channel=ARTPROGRAMS
// https://www.youtube.com/watch?v=NBdfuAxvwRQ&ab_channel=Fluidified

                    child: Column(
                      children: [
                        Row(
                          children: [
                            kText(
                              text: "Upcoming Schedule",
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async => await Get.toNamed(
                                      ApprouteNames.calenderPage),
                                  child: kText(
                                    text: "view all",
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Container(
                                  height: 1.h,
                                  width: 50.w,
                                  color: ColorConstants.darkGrey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        kHeight(30.h),
                        controller.state.schedule.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstants.mediumGreyL,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: ColorConstants.mediumGreyH,
                                      size: 40.r,
                                    ),
                                    kHeight(10.h),
                                    kText(
                                      text: 'No upcoming schedules',
                                      color: ColorConstants.mediumGreyH,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              )
                            : HomeWidgets.upcomingScheduleContainer(
                                controller: controller),
                        kHeight(30.h),
                      ],
                    ),
                  );
                }),
                Row(
                  children: [
                    kText(
                      text: "Top Doctors",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async =>
                          await Get.toNamed(ApprouteNames.doctorsPage),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kText(
                            text: "view all",
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          Container(
                            height: 1.h,
                            width: 50.w,
                            color: ColorConstants.darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                kHeight(10.h),
                SizedBox(
                  // height: 130.h,
                  child: FirestoreListView(
                      physics: const PageScrollPhysics(),
                      shrinkWrap: true,
                      query: DatabaseService.doctorsCollection.limit(5),
                      pageSize: 5,
                      itemBuilder: (context, doc) {
                        return SizedBox(
                          height: 130.h,
                          child: HomeWidgets.doctorCard(
                              name: doc.data()['name'],
                              qualifications: doc.data()['qualifications'],
                              category: doc.data()['category'],
                              imageUrl: doc.data()['profile_img_url'],
                              rating: doc.data()['rating'],
                              docId: doc.data()['id']),
                        );
                      }),
                ),
                kHeight(10.h),
                GestureDetector(
                  onTap: () async =>
                      await Get.toNamed(ApprouteNames.doctorsPage),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: kText(
                      text: 'View more',
                      color: ColorConstants.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Column kTextWithPic({required String title, required String imageUrl}) {
  return Column(
    children: [
      Image.asset(
        imageUrl,
        height: 35.h,
        width: 35.h,
      ),
      kHeight(10.h),
      kText(text: title, fontWeight: FontWeight.w500, fontSize: 18),
    ],
  );
}

Container kDoctorCard() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    width: Get.width.w,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFb4b4b4).withOpacity(1),
            offset: Offset(-3, 3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ]),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade700,
          radius: 35.r,
          backgroundImage: NetworkImage(
              'https://pngimg.com/uploads/doctor/doctor_PNG16028.png'),
        ),
        kWidth(10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight(10.h),
            SizedBox(
              width: 240.w,
              child: kText(
                text: 'name',
                maxLines: 1,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHeight(2.h),
            SizedBox(
              width: 240.w,
              child: kText(
                text: 'position',
                maxLines: 1,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHeight(4.h),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
              ],
            ),
            kHeight(5.h),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.navigation_rounded,
          color: Colors.blue,
          size: 30.r,
        )
      ],
    ),
  );
}
