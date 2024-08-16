import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:get/get.dart';

class DoctorProfileState {
  var selectedDateIndex = 4.obs;

  var name = '_'.obs;
  var qualifications = [].obs;
  var category = '_'.obs;
  var fee = '_'.obs;
  var rating = '_'.obs;
  var about = '_'.obs;
  var profileImageUrl = ''.obs;

  var isLoading = false.obs;
}
