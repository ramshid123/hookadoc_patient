import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'dart:developer' as devTools;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/services/local_notification_service.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'appointment_index.dart';

class AppointmentController extends GetxController {
  AppointmentController();
  final state = AppointmentState();

  @override
  void onReady() async {
    getDocDetails();
    await getAvailableNumOfDates();
    super.onReady();
  }

  Future getAvailableNumOfDates() async {
    final snapshot = await DatabaseService.doctorsCollection
        .where('id', isEqualTo: Get.arguments)
        .get();

    final availableDates = snapshot.docs.first
        .data()['timing']
        .where(
          (element) => DateFormat('dd/MM/yyyy').parse(element['date']).isAfter(
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day)),
        )
        .toList();

    availableDates.sort((a, b) {
      var formatter = DateFormat('dd/MM/yyyy');
      var dateA = formatter.parse(a['date']);
      var dateB = formatter.parse(b['date']);
      return dateA.compareTo(dateB);
    });

    state.availableDates.clear();

    print('the length is ${availableDates.length}');

    if (availableDates.isEmpty) {
      state.availableDates.value = [];
      state.selectedDate.value = null;
    } else {
      state.availableDates.value = availableDates;
      state.selectedDate.value =
          DateFormat('dd/MM/yyyy').parse(availableDates.first['date']);
    }
    update();
  }

  Future getDocDetails() async {
    final doctorDoc =
        await DatabaseService.getDocDetailsById(id: Get.arguments);
    // state.selectedDate.value = DateFormat('dd/MM/yyyy').parse(doctorDoc
    //     .data()['timing']
    //     .where(
    //       (element) => DateFormat('dd/MM/yyyy')
    //           .parse(element['date'])
    //           .isSameDayOrAfter(DateTime(DateTime.now().year,
    //               DateTime.now().month, DateTime.now().day)),
    //     )
    //     .first['date']);

    state.name.value = doctorDoc.data()['name'];
    state.qualifications.value = doctorDoc.data()['qualifications'];
    state.category.value = doctorDoc.data()['category'];
    state.fee.value = doctorDoc.data()['fee'];
    state.rating.value = doctorDoc.data()['rating'];
    state.profileImgUrl.value = doctorDoc.data()['profile_img_url'];
  }

  Future proceedToPayment() async {
    if (!state.selectedTime.value.isEmpty) {
      await generateOrderId();
    }
  }

  Future<void> generateOrderId() async {
    var orderOptions = {
      'amount': 100,
      'currency': "INR",
      'receipt': DateTime.now().microsecondsSinceEpoch.toString() +
          (Random().nextInt(800) + 100).toString()
    };
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${'rzp_test_On2INnaC14qZ9F'}:${'7W09OEClAjQD6CMdtMFu9Cq7'}'))}';
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) async {
      devTools.log('order id is => $contents');
      String orderId = jsonDecode(contents)['id'];
      // String orderId = contents.split(',')[0].split(":")[1];
      // orderId = orderId.substring(1, orderId.length - 1);
      await razorPayment(orderId);
    });
  }

  Future scheduleNotification(
      {required String date,
      required String time,
      required String doctorName}) async {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);

    await NotificationService().scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Appointment Reminder',
      body:
          'Your appointment with $doctorName is scheduled for today at $time.',
      channelName: 'Schedule Channel',
      channelId: 'schedule_channel_01',
      iconPath: '@raw/schedule',
      largeIconPath: '@raw/schedule',
      dateTime: dateTime,
    );
  }

  Future razorPayment(String orderId) async {
    final razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    var options = {
      'key': 'rzp_test_On2INnaC14qZ9F',
      'order_id': orderId,
      'name': state.name.value,
      'description': 'Book an appointment with ${state.name.value}',
      'prefill': {'contact': '9999999999', 'email': 'test@test.com'},
      'readonly': {
        'contact': true,
        'email': true,
        'name': true,
      },
      'hidden': {'contact': true, 'email': true},
    };
    razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    final doctorDoc = await DatabaseService.doctorsCollection
        .where('id', isEqualTo: Get.arguments)
        .get();
    Map<String, dynamic> doctorSchedule = {};
    Map<String, dynamic> takerSchedule = {};
    List timings = doctorDoc.docs.first['timing'];
    for (var timing in timings) {
      if (timing['date'] ==
          DateFormat('dd/MM/yyyy').format(state.selectedDate.value!)) {
        for (var seat in timing['seats']) {
          if (seat['time'] == state.selectedTime.value.split('#').last) {
            seat['avail'] = false;
            seat['taker_id'] = 'the_takers_unique_id';
            seat['taker_name'] = 'the taker\'s name';
            doctorSchedule = {
              'date': timing['date'],
              'time': seat['time'],
              'taker_id':
                  (await SharedPrefHelpers.getValue(key: SharedPrefHelpers.uid))
                      .toString(),
              'taker_name': (await SharedPrefHelpers.getValue(
                      key: SharedPrefHelpers.name))
                  .toString(),
              'schedule_id':
                  'doc_${DateTime.now().microsecondsSinceEpoch + Random.secure().nextInt(100)}'
            };
            takerSchedule = {
              'date': timing['date'],
              'time': seat['time'],
              'doc_name': doctorDoc.docs.first['name'],
              'geo': doctorDoc.docs.first['geo'],
              'category': doctorDoc.docs.first['category'],
              'doc_id': doctorDoc.docs.first['id'],
              'qualifications': doctorDoc.docs.first['qualifications'],
              'profile_img_url': doctorDoc.docs.first['profile_img_url'],
              'schedule_id':
                  'tak_${DateTime.now().microsecondsSinceEpoch + Random.secure().nextInt(100)}'
            };
          }
        }
      }
    }
    if (doctorSchedule.isNotEmpty) {
      await doctorDoc.docs.first.reference.update({
        'timing': timings,
        'schedules': FieldValue.arrayUnion([doctorSchedule]),
      });
    }

    final currentPatientSnapshot = await DatabaseService.takersCollection
        .where('uid',
            isEqualTo:
                await SharedPrefHelpers.getValue(key: SharedPrefHelpers.uid))
        .get();
    currentPatientSnapshot.docs.first.reference.update({
      'schedules': FieldValue.arrayUnion([takerSchedule]),
    });

    await scheduleNotification(
        date: takerSchedule['date'],
        time: takerSchedule['time'],
        doctorName: takerSchedule['doc_name']);

    state.selectedTime.value = '';
    await Get.offAllNamed(ApprouteNames.bookingSuccessPage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    devTools.log('on Error : ${response.error} \n ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('on wallet select : ${response.walletName}');
  }
}
