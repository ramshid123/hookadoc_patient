import 'package:get/get.dart';

class CalenderState {
  var userID = ''.obs;

  var scheduledOrHistory = 0.obs;

  var selectedDate = DateTime.now().add(Duration(days: 365)).obs;

  var schedules = [].obs;
}
