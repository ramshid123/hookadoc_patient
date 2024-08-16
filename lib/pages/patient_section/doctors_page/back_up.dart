import 'package:doctor_app_v2/pages/patient_section/doctors_page/doctors_index.dart';
import 'package:doctor_app_v2/pages/patient_section/home_page/home_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorsPage extends GetView<DoctorsController> {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.navigate_before),
            color: Colors.black,
            iconSize: 40.r,
          ),
          centerTitle: true,
          title: kText(
            text: 'Our Doctors',
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: Colors.black,
              iconSize: 40.r,
            )
          ],
        ),
        body: Column(
          children: [
            kHeight(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
                    // height: 250.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blue.shade900],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35.r,
                            ),
                            kWidth(15.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 250.w,
                                  child: kText(
                                    text: 'Find doctors!',
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                kHeight(5.h),
                                SizedBox(
                                  width: 250.w,
                                  child: kText(
                                    text:
                                        'Use this feature to find closest doctors to you.',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        kHeight(10.h),
                        Stack(
                          children: [
                            Container(
                              height: 150.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Obx(() {
                                return GoogleMap(
                                  zoomControlsEnabled: false,
                                  padding: EdgeInsets.only(top: 135.h),
                                  initialCameraPosition: CameraPosition(
                                    target:
                                        controller.state.currentPosition.value,
                                    zoom: 12,
                                  ),
                                  onMapCreated: (cont) {
                                    controller.state.mapController = cont;
                                  },
                                );
                              }),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(ApprouteNames.mapPage),
                              child: Container(
                                color: Colors.transparent,
                                height: 150.h,
                                width: Get.width,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  kHeight(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      kText(
                        text: 'Nearby Doctors',
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                      kText(
                        text: 'See all',
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  kHeight(10.h),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => kDoctorCard(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
