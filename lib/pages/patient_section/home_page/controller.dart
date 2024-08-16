import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/services/hive_service.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'home_index.dart';

class HomeController extends GetxController {
  HomeController();
  final state = HomeState();

  @override
  void onInit() async {
    // TODO: implement onInit
    getUpcomingMedicines();
    getUpcomingSchedule();
    super.onInit();
  }

  Future getUpcomingSchedule() async {
    final patientSnapshot = await DatabaseService.takersCollection
        .where('uid',
            isEqualTo:
                await SharedPrefHelpers.getValue(key: SharedPrefHelpers.uid))
        .get();

    // patientSnapshot.docs.first.data()['schedules'] =
    //     patientSnapshot.docs.first.data()['schedules'].where((appointment) {
    //   DateTime appointmentDateTime = DateFormat('dd/MM/yyyy hh:mm a')
    //       .parse(appointment['date'] + ' ' + appointment['time']);
    //   return appointmentDateTime.isAfter(DateTime.now());
    // }).toList();

    // state.schedule.value = List<Map<String, dynamic>>.from(
    //         patientSnapshot.docs.first.data()['schedules'])
    //     .first;

    if (patientSnapshot.docs.first.data()['schedules'].isNotEmpty) {
      patientSnapshot.docs.first.data()['schedules'].sort((a, b) {
        final DateTime dateTimeA =
            DateFormat('dd/MM/yyyy hh:mm a').parse('${a['date']} ${a['time']}');
        final DateTime dateTimeB =
            DateFormat('dd/MM/yyyy hh:mm a').parse('${b['date']} ${b['time']}');
        return dateTimeA.compareTo(dateTimeB);
      });

      final schedules =
          patientSnapshot.docs.first.data()['schedules'].where((appointment) {
        DateTime appointmentDateTime = DateFormat('dd/MM/yyyy hh:mm a')
            .parse(appointment['date'] + ' ' + appointment['time']);
        return appointmentDateTime.isAfter(DateTime.now());
      }).toList();

      if (schedules.isNotEmpty) {
        state.schedule.value = patientSnapshot.docs.first
            .data()['schedules']
            .where((appointment) {
              DateTime appointmentDateTime = DateFormat('dd/MM/yyyy hh:mm a')
                  .parse(appointment['date'] + ' ' + appointment['time']);
              return appointmentDateTime.isAfter(DateTime.now());
            })
            .toList()
            .first;
      }
    }
  }

  Future getUpcomingMedicines() async {
    state.medicineList.clear();
    final allMedicines = await HiveServices.getMedicines();
    for (var medicine in allMedicines) {
      for (var time in medicine.timings) {
        state.medicineList.value = [
          ...state.medicineList,
          MedicineModel(
            pillName: medicine.pillName,
            amount: medicine.amount,
            description: medicine.description,
            medicineForm: medicine.medicineForm,
            id: medicine.id,
            startDate: medicine.startDate,
            timings: [time],
          )
        ];
      }

      state.medicineList.removeWhere(
          (element) => element.getFirstTimingAsDateTime().isBefore(DateTime(
                2023,
                1,
                1,
                DateTime.now().hour,
                DateTime.now().minute,
              )));
      state.medicineList.sort(MedicineModel.compareByFirstTiming);
      state.medicineList.refresh();
    }
  }
}
