import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:doctor_app_v2/services/hive_service.dart';
import 'package:doctor_app_v2/services/local_notification_service.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:doctor_app_v2/shared/helpers/helper_functions.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'addmedicine_index.dart';

class AddMedicineController extends GetxController {
  AddMedicineController();
  final state = AddMedicineState();

  Future<void> showCustomTimePicker({required BuildContext context}) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: ColorConstants.darkGrey,
            colorScheme:
                ColorScheme.light().copyWith(primary: ColorConstants.darkGrey),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      state.timings.value = [...state.timings, time.format(context)];
    }
  }

  Future scheduleNotification() async {
    final amount = int.parse(state.amountCont.text);
    final durationInDays = amount / state.timings.length;

    String? lastNotificationIdInString = await SharedPrefHelpers.getValue(
        key: SharedPrefHelpers.medicineNotificationId);
    if (lastNotificationIdInString == null) {
      await SharedPrefHelpers.setValue(
          key: SharedPrefHelpers.medicineNotificationId, value: '100');
      lastNotificationIdInString = await SharedPrefHelpers.getValue(
          key: SharedPrefHelpers.medicineNotificationId);
    }

    int lastNotificationIdinInt = int.parse(lastNotificationIdInString!);

    for (int i = 0; i < durationInDays; i++) {
      for (var time in state.timings) {
        final dateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateFormat('hh:mm a').parse(time).hour,
          DateFormat('hh:mm a').parse(time).minute,
        ).add(Duration(days: i));

        await NotificationService().scheduleNotification(
          channelName: 'Medicine Notifier',
          channelId: 'medicine_notifier_01',
          id: lastNotificationIdinInt,
          body: state.pillNameCont.text,
          title: 'Time for your medicine.',
          dateTime: dateTime,
          iconPath: '@raw/pills',
          largeIconPath: '@raw/pills',
        );
        print('${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateFormat('hh:mm a').parse(time).hour,
          DateFormat('hh:mm a').parse(time).minute,
        ).add(Duration(days: i)))} | id : $lastNotificationIdinInt');
        lastNotificationIdinInt++;
      }
    }

    await SharedPrefHelpers.setValue(
        key: SharedPrefHelpers.medicineNotificationId,
        value: (lastNotificationIdinInt + 1).toString());
  }

  Future addMedicine({required BuildContext context}) async {
    if (state.formkey.currentState!.validate() &&
        state.pillNameCont.text.isNotEmpty &&
        state.amountCont.text.isNotEmpty &&
        state.medicineFormCont.text.isNotEmpty &&
        state.timings.isNotEmpty) {
      state.isLoading.value = true;
      try {
        final medicineItem = MedicineModel(
          pillName: state.pillNameCont.text,
          amount: state.amountCont.text,
          description: state.descriptionCont.text,
          medicineForm: state.medicineFormCont.text,
          timings: state.timings,
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          startDate: DateTime.now().toString(),
        );
        await HiveServices.addMedicine(item: medicineItem);
        await scheduleNotification();
        Helpers.showGetSnackbar(
            title: 'Done', message: 'Medicine added.', icon: Icons.check);
      } catch (e) {
        print(e);
        Helpers.showGetSnackbar(
            title: 'Oops!!',
            message: 'Something went wrong.',
            icon: Icons.warning);
      } finally {
        state.formkey.currentState!.reset();
        state.timings.clear();
        state.isLoading.value = false;
      }
    } else if (state.timings.isEmpty) {
      Helpers.showGetSnackbar(
          title: 'No Timings',
          message: 'Please add some timings for the medicine.',
          icon: Icons.warning);
    }
  }
}
