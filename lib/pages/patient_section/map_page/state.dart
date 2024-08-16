import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorMapState {
  GoogleMapController? mapController;
  var currentPosition = LatLng(0, 0).obs;

  Rx<GeoFirePoint> center = const GeoFirePoint(GeoPoint(0, 0)).obs;

  var selectedRadius = 1.0.obs;

  RxList<GeoDocumentSnapshot<Map<String, dynamic>>> nearbyDocs =
      <GeoDocumentSnapshot<Map<String, dynamic>>>[].obs;
  var nearbyDocsMarkers = <Marker>{}.obs;

  var customDoctorMarker = BitmapDescriptor.defaultMarker.obs;
  var customMyLocationMarker = BitmapDescriptor.defaultMarker.obs;

  var mapStyleJson = '';
}
