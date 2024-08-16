import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:doctor_app_v2/services/auth_service.dart';
import 'package:doctor_app_v2/models/time_slot_model.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/services/database_service.dart';
import 'package:doctor_app_v2/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'signup_index.dart';

class SignUpController extends GetxController {
  SignUpController();
  final state = SignUpState();

  Future validateTextForms(
      {required GlobalKey<FormState> formkey,
      required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    if (formkey.currentState!.validate() && formkey == state.formKey1) {
      state.pageController.animateToPage(1,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    } else if (formkey.currentState!.validate() && formkey == state.formKey2) {
      state.pageController.animateToPage(2,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    } else if (formkey == state.formKey3 && state.isTermsAgreed.value) {
      print('validated and continue');
      await createAccountBackend();
      // showLoadingScreen(context);
    }
  }

  bool onwillPopScope() {
    if (state.pageController.page == 0.0) {
      return true;
    } else if (state.pageController.page == 1.0) {
      state.pageController.animateToPage(0,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      return false;
    } else if (state.pageController.page == 2.0) {
      state.pageController.animateToPage(1,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      return false;
    } else {
      return true;
    }
  }

  // Future getCurrentPosition() async {
  //   state.isLoading.value = true;
  //   try {
  //     final permission = await Permission.locationWhenInUse.request();
  //     if (permission.isDenied || permission.isPermanentlyDenied) {
  //       Get.back();
  //     }
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     state.currentPosition.value =
  //         LatLng(position.latitude, position.longitude);
  //     state.marker.value = Marker(
  //         markerId: MarkerId('clinic'),
  //         position: LatLng(position.latitude, position.longitude));
  //     await state.mapController!
  //         .animateCamera(CameraUpdate.newLatLng(state.currentPosition.value));
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     state.isLoading.value = false;
  //   }
  // }

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
          child: RiveAnimation.asset('assets/heart_rate.riv'),
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 10));
    Get.back();
  }

  Future selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    state.dob.text = DateFormat("dd/MM/yyyy").format(date!);
  }

  Future createAccountBackend() async {
    state.isLoading.value = true;
    try {
      final uid = await AuthService.createAccount(
          phone: state.phoneNo.text, password: state.password.text);

      final imageUrl = state.avatarPic != null
          ? await StorageService.uploadPicture(
              path: state.avatarPic!.path,
              phone: state.phoneNo.text,
            )
          : 'none';

      await DatabaseService.createTakerAccount(
        phone: state.phoneNo.text,
        name: state.name.text,
        uid: uid,
        dob: state.dob.text,
        address: state.address.text,
        imageUrl: imageUrl,
      );

      await Get.offAllNamed(ApprouteNames.homePage);
    } catch (e) {
      print(e);
    } finally {
      state.isLoading.value = false;
    }
  }
}
