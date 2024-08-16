import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

class AppointmentState {
  CleanCalendarController? calendarController;

  var selectedTimeBoxIndex = 0.obs;

  Rx<DateTime?> selectedDate = DateTime.now().add(Duration(days: 365)).obs;

  var name = '_'.obs;
  var qualifications = [].obs;
  var category = '_'.obs;
  var fee = '_'.obs;
  var rating = '_'.obs;
  var profileImgUrl = ''.obs;

  var selectedTime = ''.obs;

  var morningOrEveningSelection = 0.obs;

  var availableDates = [].obs;

  //----------------------------------

  var GetDotArguments = 'Jr3j00hkt0HJp6v0iEoj';
}
