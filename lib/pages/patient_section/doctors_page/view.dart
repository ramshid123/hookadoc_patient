import 'dart:math';

import 'package:doctor_app_v2/pages/patient_section/doctors_page/doctors_index.dart';
import 'package:doctor_app_v2/pages/patient_section/doctors_page/widgets.dart';
import 'package:doctor_app_v2/pages/patient_section/home_page/home_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorsPage extends GetView<DoctorsController> {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getLocationPermission(context: context);
    return Scaffold(
      body: Column(
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
                  text: 'Doctors',
                  color: ColorConstants.darkGrey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () async => await Get.toNamed(ApprouteNames.mapPage),
                  child: Icon(
                    Icons.location_pin,
                    // Icons.tune,
                    color: ColorConstants.darkGrey,
                    size: 35.r,
                  ),
                ),
              ],
            ),
          ),
          kHeight(25.h),
          Container(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) =>
                  DoctorsWidgets.doctorCategoryCard(
                      isSelected: index == 1, text: 'Cardiologist'),
            ),
          ),
          kHeight(20.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.state.nearbyDocs.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.state.nearbyDocs[index];
                    return DoctorsWidgets.doctorCard(
                        name: doctor.documentSnapshot.data()!['name'],
                        docId: doctor.documentSnapshot.data()!['id'],
                        qualifications:
                            doctor.documentSnapshot.data()!['qualifications'],
                        category: doctor.documentSnapshot.data()!['category'],
                        imageUrl:
                            doctor.documentSnapshot.data()!['profile_img_url'],
                        rating: doctor.documentSnapshot.data()!['rating']);
                  },
                );
              }),
              // child: FirestoreListView(
              //   query:
              //   itemBuilder: (context, doc) {
              //     final doctor = doc.data();
              //     return DoctorsWidgets.doctorCard(
              //       name: doctor['name'],
              //       qualifications: doctor['qualifications'],
              //       category: doctor['category'],
              //       imageUrl: doctor['profile_img_url'],
              //       rating: doctor['rating'],
              //     );
              //   },
              // ),
            ),
          )
        ],
      ),
    );
  }
}
