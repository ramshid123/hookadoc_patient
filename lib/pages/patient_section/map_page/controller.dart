import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/pages/patient_section/map_page/widgets.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'doctormap_index.dart';

class DoctorMapController extends GetxController {
  DoctorMapController();
  final state = DoctorMapState();

  @override
  void onReady() async {
    // TODO: implement onReady
    state.mapStyleJson =
    await rootBundle.loadString('assets/json_files/map_style_json.json'); // TODO : Dark mode for Maps

    await initCustomMarkers();
    await getCurrentPosition();
    await fetchDoctorsInRadius();
    super.onReady();
  }

  Future initCustomMarkers() async {
    state.customDoctorMarker.value =
        await DoctorMapWidgets.customDoctorMarker().toBitmapDescriptor();
    state.customMyLocationMarker.value =
        await DoctorMapWidgets.customMyLocationMarker().toBitmapDescriptor();
  }

  Future fetchDoctorsInRadius() async {
    state.nearbyDocs.clear();
    state.nearbyDocsMarkers.clear();
    state.center.value = GeoFirePoint(GeoPoint(
        state.currentPosition.value.latitude,
        state.currentPosition.value.longitude));
    state.nearbyDocs.value =
        await GeoCollectionReference(DatabaseService.doctorsCollection)
            .fetchWithinWithDistance(
      center: state.center.value,
      radiusInKm: state.selectedRadius.value,
      field: 'geo',
      geopointFrom: (data) =>
          (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
    );

    for (var item in state.nearbyDocs) {
      state.nearbyDocsMarkers.value = {
        ...state.nearbyDocsMarkers.value,
        Marker(
          markerId: MarkerId(item.documentSnapshot.data()!['id']),
          icon: state.customDoctorMarker.value,
          position: LatLng(
              item.documentSnapshot.data()!['geo']['geopoint'].latitude,
              item.documentSnapshot.data()!['geo']['geopoint'].longitude),
          onTap: () async => await showDocDetailsPopup(
            context: Get.context!,
            name: item.documentSnapshot.data()!['name'],
            latlong: LatLng(
                item.documentSnapshot.data()!['geo']['geopoint'].latitude,
                item.documentSnapshot.data()!['geo']['geopoint'].longitude),
            fee: item.documentSnapshot.data()!['fee'],
            docId: item.documentSnapshot.data()!['id'],
            category: item.documentSnapshot.data()!['category'],
            imageUrl: item.documentSnapshot.data()!['profile_img_url'],
            qualifications: item.documentSnapshot.data()!['qualifications'],
            rating: item.documentSnapshot.data()!['rating'],
          ),
          infoWindow: InfoWindow(
            snippet: item.documentSnapshot.data()!['category'],
            title: item.documentSnapshot.data()!['name'],
          ),
        )
      };
    }
    state.nearbyDocsMarkers.refresh();
  }

  Future getCurrentPosition() async {
    try {
      final permission = await Permission.locationWhenInUse.request();
      if (permission.isDenied || permission.isPermanentlyDenied) {
        Get.back();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      state.currentPosition.value =
          LatLng(position.latitude, position.longitude);
      await state.mapController!
          .animateCamera(CameraUpdate.newLatLng(state.currentPosition.value));
    } catch (e) {
      print(e);
    }
  }

  Future showFilterPopup({required BuildContext context}) async {
    await showModalBottomSheet(
      context: context,
      barrierColor: ColorConstants.darkGrey.withOpacity(0.5),
      backgroundColor: ColorConstants.darkGrey.withOpacity(0),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) =>
          DoctorMapWidgets.filterBottomSheet(controller: this),
    );
  }

  Future showDocDetailsPopup({
    required BuildContext context,
    required String name,
    required List<dynamic> qualifications,
    required String category,
    required String fee,
    required String docId,
    required LatLng latlong,
    required String imageUrl,
    required String rating,
  }) async {
    await showModalBottomSheet(
      context: context,
      barrierColor: ColorConstants.lightGrey.withOpacity(0.4),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => TemporaryContainer(
          controller: this,
          name: name,
          fee: fee,
          docId: docId,
          latlong: latlong,
          qualifications: qualifications,
          category: category,
          imageUrl: imageUrl,
          rating: rating),
    );
  }
}
