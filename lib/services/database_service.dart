import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/models/time_slot_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseService {
  static final instance = FirebaseFirestore.instance;

  static final takersCollection = instance.collection('Takers');
  static final doctorsCollection = instance.collection('Doctors');

  static Future<QueryDocumentSnapshot<Map<String, dynamic>>>
      getPatiendDetailById({required String id}) async {
    final takerSnapshot =
        await takersCollection.where('uid', isEqualTo: id).get();
    return takerSnapshot.docs.first;
  }

  // static Future createDoctorAccount(
  //     {required String phone,
  //     required String password,
  //     required String name,
  //     required String uid,
  //     required String experience,
  //     required String bio,
  //     required String timeSlots,
  //     required String imageUrl,
  //     required LatLng location}) async {
  //   final newDoc = doctorsCollection.doc();
  //   await doctorsCollection.doc(newDoc.id).set({
  //     'phone': phone,
  //     'password': password,
  //     'name': name,
  //     'exp': experience,
  //     'image_url': imageUrl,
  //     'bio': bio,
  //     'location': '${location.latitude}#${location.longitude}',
  //     'time_slots': timeSlots,
  //     'doc_id': newDoc.id,
  //     'uid': uid,
  //   });
  // }

  static Future createTakerAccount(
      {required String phone,
      required String name,
      required String uid,
      required String dob,
      required String address,
      required String imageUrl}) async {
    await takersCollection.add({
      'phone': phone,
      'uid': uid,
      'dob': dob,
      'name': name,
      'address': address,
      'image_url': imageUrl,
    });
  }

  static Future<QueryDocumentSnapshot<Map<String, dynamic>>> getDocDetailsById(
      {required String id}) async {
    final response = await doctorsCollection.where('id', isEqualTo: id).get();
    return response.docs.first;
  }
}
