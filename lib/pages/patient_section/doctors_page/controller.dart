import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';
import 'doctors_index.dart';

class DoctorsController extends GetxController {
  DoctorsController();
  final state = DoctorsState();

  @override
  void onReady() async {
    // TODO: implement onReady
    // await getCurrentPosition();

    super.onReady();
  }

  void showPermissionDeniedDialog(context) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow permission to access your location'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Future getLocationPermission({required BuildContext context}) async {
    final permission = await Permission.locationWhenInUse.request();
    final isPermitted = await Permission.locationWhenInUse.isGranted;
    if (permission.isDenied || permission.isPermanentlyDenied || !isPermitted) {
      showPermissionDeniedDialog(context);
    }
    await getCurrentPosition();
    await fetchDoctorsInRadius();
  }

  Future fetchDoctorsInRadius() async {
    state.nearbyDocs.value =
        await GeoCollectionReference(DatabaseService.doctorsCollection)
            .fetchWithinWithDistance(
      center: state.center.value,
      radiusInKm: state.selectedRadius.value,
      field: 'geo',
      geopointFrom: (data) =>
          (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
    );
  }

  Future getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      state.center.value =
          GeoFirePoint(GeoPoint(position.latitude, position.longitude));
      state.currentPosition.value =
          LatLng(position.latitude, position.longitude);
      await state.mapController!
          .animateCamera(CameraUpdate.newLatLng(state.currentPosition.value));
    } catch (e) {
      print(e);
    }
  }
}
