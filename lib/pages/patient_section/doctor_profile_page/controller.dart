import 'package:doctor_app_v2/services/database_service.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'doctorprofile_index.dart';

class DoctorProfileController extends GetxController {
  DoctorProfileController();
  final state = DoctorProfileState();

  @override
  void onReady() async {
    // TODO: implement onReady
    await getDocDetails();
    super.onReady();
  }

  Future getDocDetails() async {
    try {
      state.isLoading.value = true;
      final docId = Get.arguments;
      final doctorFirestoreDocs = await DatabaseService.doctorsCollection
          .where('id', isEqualTo: docId)
          .get();
      final doctorSnapshot = doctorFirestoreDocs.docs.first;
      state.name.value = doctorSnapshot.data()['name'];
      state.qualifications.value = doctorSnapshot.data()['qualifications'];
      state.category.value = doctorSnapshot.data()['category'];
      state.fee.value = doctorSnapshot.data()['fee'];
      state.profileImageUrl.value = doctorSnapshot.data()['profile_img_url'];
      state.rating.value = doctorSnapshot.data()['rating'];
      state.about.value = doctorSnapshot.data()['about'];
    } catch (e) {
      print(e);
    } finally {
      state.isLoading.value = false;
    }
  }

  Future razorPayMethod() async {
    try {
      Razorpay razorPay = Razorpay();
      // Map<String, dynamic> options = {
      //   'key': '7W09OEClAjQD6CMdtMFu9Cq7',
      //   'amount': '100',
      //   'name': 'Ramsheed Dilhan',
      //   'description': 'Test mode payment test',
      //   'retry': {'enabled': true, 'max_count': 1},
      //   'send_sms_hash': true,
      //   'prefill': {'contact': '9847969459', 'email': 'dramsheed@gmail.com'},
      //   'external': {
      //     'wallets': ['paytm'],
      //   }
      // };
      var options = {
        'key': 'rzp_test_On2INnaC14qZ9F',
        'amount': 100,
        'name': 'Uppa',
        'description': 'Fine T-Shirt',
        // 'prefill': {'contact': '9961298459'},
      };
      razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      razorPay.open(options);
    } on PaymentFailureResponse catch (e) {
      print(e.message);
      print(e.code);
    }
  }
  // 7510 871 509

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        '\n-------------------------------\nSuccess\n------------------------------------\n');
    Get.showSnackbar(GetSnackBar(
      title: 'Success',
      message: 'message',
      duration: 3.seconds,
    ));
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        '\n-------------------------------\nFail\n------------------------------------\n');
    Get.showSnackbar(GetSnackBar(
      title: 'Fail',
      message: 'message',
      duration: 3.seconds,
    ));

    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(
        '\n-------------------------------\nexternal wallted selected\n------------------------------------\n');
    Get.showSnackbar(GetSnackBar(
      title: 'external wallted selected',
      message: 'message',
      duration: 3.seconds,
    ));

    // Do something when an external wallet was selected
  }
}
