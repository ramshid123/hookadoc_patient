import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorsState {
  GoogleMapController? mapController;
  var currentPosition = const LatLng(11.254256928618227, 75.83712624257831).obs;

  final Rx<GeoFirePoint> center = const GeoFirePoint(
    GeoPoint(11.254256928618227, 75.83712624257831),
  ).obs;

  RxList<GeoDocumentSnapshot<Map<String, dynamic>>> nearbyDocs =
      <GeoDocumentSnapshot<Map<String, dynamic>>>[].obs;

  var selectedRadius = 1.0.obs;
}
