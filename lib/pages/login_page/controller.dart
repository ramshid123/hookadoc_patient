import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/auth_service.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/shared/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_index.dart';

class LoginController extends GetxController {
  LoginController();
  final state = LoginState();

  Future validateTextForms(
      {required GlobalKey<FormState> formkey,
      required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    if (formkey.currentState!.validate()) {
      // showLoadingScreen(context);
      await login();
    }
  }

  bool onwillPopScope() {
    Get.offAllNamed(ApprouteNames.signUpPage);
    return false;
  }

  void showLoadingScreen(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      // barrierColor: Colors.blue[300]!.withOpacity(0.5),
      barrierColor: Colors.white70,
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 100.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: WillPopScope(
          onWillPop: () async => false,
          child: SizedBox(
            height: 50.h,
            width: 50.h,
            child: const RiveAnimation.asset(
              'assets/heart_rate_black (1).riv',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
    await Future.delayed(4.seconds);
    Get.back();
  }

  Future login() async {
    state.isLoading.value = true;
    try {
      final uid = await AuthService.login(
          phone: state.phoneNo.text, password: state.password.text);
      print('uid is : $uid');
      await SharedPrefHelpers.setValue(key: SharedPrefHelpers.uid, value: uid);
      await SharedPrefHelpers.setValue(
          key: SharedPrefHelpers.phone, value: state.phoneNo.text);
      final patientDoc = await DatabaseService.getPatiendDetailById(id: uid);
      await SharedPrefHelpers.setValue(
          key: SharedPrefHelpers.name, value: patientDoc.data()['name']);
      await Get.offAllNamed(ApprouteNames.homePage);
    } catch (e) {
      print(e);
    } finally {
      await Future.delayed(1.seconds);
      state.isLoading.value = false;
    }
  }
}
