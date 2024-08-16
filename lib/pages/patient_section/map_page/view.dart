import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/pages/patient_section/map_page/widgets.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'doctormap_index.dart';

class DoctorMapPage extends GetView<DoctorMapController> {
  const DoctorMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 70.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 70.h,
          color: ColorConstants.darkGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back,
                  color: ColorConstants.whiteColor,
                  size: 30.r,
                ),
              ),
              kText(
                text: 'Doctors Nearby',
                color: ColorConstants.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.showFilterPopup(context: context);
                },
                child: Icon(
                  Icons.tune,
                  color: ColorConstants.whiteColor,
                  size: 30.r,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.state.currentPosition.value,
            zoom: 15,
          ),
          onMapCreated: (cont) {
            controller.state.mapController = cont;
            controller.state.mapController!
                .setMapStyle(controller.state.mapStyleJson);
          },
          buildingsEnabled: false,
          trafficEnabled: false,
          myLocationEnabled: true,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          circles: {
            Circle(
              circleId: CircleId('#circle'),
              center: controller.state.currentPosition.value,
              radius: controller.state.selectedRadius.value * 1000,
              fillColor: ColorConstants.lightGrey.withOpacity(0.1),
              strokeColor: ColorConstants.darkGrey,
              strokeWidth: 3,
              visible: true,
            )
          },
          markers: {
            Marker(
                zIndex: 1,
                markerId: MarkerId('#my_location'),
                icon: controller.state.customMyLocationMarker.value,
                position: LatLng(
                    controller.state.currentPosition.value.latitude,
                    controller.state.currentPosition.value.longitude)),
            for (var marker in controller.state.nearbyDocsMarkers) marker,
          },
        );
      }),
    );
  }
}
