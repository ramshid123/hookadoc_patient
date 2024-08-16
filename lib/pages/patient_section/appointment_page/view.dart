import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/pages/patient_section/appointment_page/appointment_index.dart';
import 'package:doctor_app_v2/pages/patient_section/appointment_page/widgets.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

class AppointMentPage extends GetView<AppointmentController> {
  const AppointMentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final geoFirePoint =
              GeoFirePoint(GeoPoint(11.328379847850636, 75.88615033707268));
          final formatter = DateFormat('dd/MM/yyyy');
          List dates = [];
          dates.add(
              formatter.format(DateTime.now().subtract(Duration(days: 1))));
          dates.add(formatter.format(DateTime.now()));
          dates.add(formatter.format(DateTime.now().add(Duration(days: 1))));
          await DatabaseService.doctorsCollection
              .doc('Jr3j00hkt0HJp6v0iEoj')
              .update({
            'id': 'Jr3j00hkt0HJp6v0iEoj',
            'about':
                "I'm a cardiologist with over 10 years of experience. I've treated over 100 patients with a variety of heart conditions. I'm passionate about providing my patients with the best possible care and helping them live long and healthy lives.\nI'm a strong advocate for patient education and empowerment. I believe that patients should be active participants in their own care. I take the time to explain my patients' conditions to them in a way that they can understand. I also encourage them to ask questions and make informed decisions about their treatment.\nI'm a compassionate and caring physician who is dedicated to helping my patients. I believe that everyone deserves access to quality healthcare. I'm committed to providing my patients with the best possible care, regardless of their background or financial situation.\nIf you're looking for a cardiologist who is experienced, passionate, and compassionate, I encourage you to contact me. I would be happy to discuss your condition and treatment options with you.",
            'name': 'Dr. Andres Vidoza',
            'category': 'Cardiologist',
            'qualifications': ['MBBS', 'FCSP'],
            'fee': '200',
            'rating': '4.6',
            'profile_img_url':
                'https://img.freepik.com/free-photo/portrait-male-doctor-special-equipment_23-2148980809.jpg',
            'geo': geoFirePoint.data,
            'timing': [
              {
                'date': dates[0],
                'seats': [
                  {
                    'time': '10:00 AM',
                    'avail': true,
                  },
                  {
                    'time': '11:00 AM',
                    'avail': true,
                  },
                  {
                    'time': '12:10 PM',
                    'avail': true,
                  },
                  {
                    'time': '1:20 PM',
                    'avail': true,
                  },
                  {
                    'time': '2:30 PM',
                    'avail': true,
                  },
                ],
              },
              {
                'date': dates[1],
                'seats': [
                  {
                    'time': '10:30 AM',
                    'avail': true,
                  },
                  {
                    'time': '11:30 AM',
                    'avail': true,
                  },
                  {
                    'time': '12:20 PM',
                    'avail': true,
                  },
                  {
                    'time': '1:10 PM',
                    'avail': true,
                  },
                  {
                    'time': '2:30 PM',
                    'avail': true,
                  },
                ],
              },
              {
                'date': dates[2],
                'seats': [
                  {
                    'time': '10:00 AM',
                    'avail': true,
                  },
                  {
                    'time': '11:00 AM',
                    'avail': true,
                  },
                  {
                    'time': '12:10 PM',
                    'avail': true,
                  },
                  {
                    'time': '1:20 PM',
                    'avail': true,
                  },
                  {
                    'time': '2:30 PM',
                    'avail': true,
                  },
                ],
              }
            ]
          });
        },
      ),
      bottomNavigationBar:
          AppointmentWidgets.bookNowButton(controller: controller),
      body: SizedBox(
        height: Get.height - 100.h,
        child: Column(
          children: [
            kHeight(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
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
                    text: 'Appointment',
                    color: ColorConstants.darkGrey,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(),
                ],
              ),
            ),
            kHeight(20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Obx(() {
                            return Row(
                              children: [
                                //photo
                                Container(
                                  height: 90.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.lightGrey,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: ColorConstants.darkGrey,
                                      width: 1.w,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Image.network(
                                      controller.state.profileImgUrl.value,
                                      height: 85.h,
                                      width: 95.w,
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
                                    kText(
                                      text: controller.state.category.value,
                                      fontSize: 16,
                                      color: ColorConstants.mediumGreyH,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                          kHeight(20.h),
                          Obx(() {
                            return Row(
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
                            );
                          }),
                          kHeight(20.h),
                        ],
                      ),
                    ),
                    AppointmentWidgets.customDatePicker(
                        controller: controller, title: 'Schedule'),
                    kHeight(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          AppointmentWidgets.selectMorningOrEvening(
                              controller: controller),
                          kHeight(10.h),
                          GetBuilder(
                              init: controller,
                              builder: (controller) {
                                return controller.state.selectedDate.value ==
                                            null ||
                                        controller.state.selectedDate.value!
                                                .difference(DateTime.now()) >
                                            Duration(days: 30)
                                    ? Center(
                                        child: kText(
                                            text: 'No slots are available'),
                                      )
                                    : FirestoreListView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        query: DatabaseService.doctorsCollection
                                            .where('id',
                                                isEqualTo: Get.arguments),
                                        itemBuilder: (context, doc) {
                                          var seats = [];
                                          controller.state.selectedDate.value !=
                                                  null
                                              ? seats = doc['timing']
                                                  .firstWhere(
                                                      (timing) =>
                                                          timing['date'] ==
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(controller
                                                                  .state
                                                                  .selectedDate
                                                                  .value!),
                                                      orElse: () =>
                                                          null)['seats']
                                              : [];

                                          final amList = [];
                                          final pmList = [];

                                          for (var seat in seats) {
                                            if (seat['time'].contains('AM') &&
                                                seats.isNotEmpty)
                                              amList.add(seat);
                                            else if (seat['time']
                                                    .contains('PM') &&
                                                seats.isNotEmpty)
                                              pmList.add(seat);
                                          }
                                          return Obx(() {
                                            return Wrap(
                                              spacing: 15.w,
                                              runSpacing: 10.h,
                                              children: [
                                                if (controller
                                                        .state
                                                        .morningOrEveningSelection
                                                        .value ==
                                                    0)
                                                  for (var time in amList)
                                                    AppointmentWidgets.timeTile(
                                                        controller: controller,
                                                        time: time)
                                                else
                                                  for (var time in pmList)
                                                    AppointmentWidgets.timeTile(
                                                        controller: controller,
                                                        time: time)
                                              ],
                                            );
                                          });
                                        },
                                      );
                              }),
                          kHeight(50.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
