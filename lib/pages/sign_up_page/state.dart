import 'package:doctor_app_v2/models/time_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:zego_zimkit/compnents/messages/widgets/pick_file_button.dart';

class SignUpState {
  // selection page states

  var isLoading = false.obs;

  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var formKey3 = GlobalKey<FormState>();
  var pageController = PageController();
  //--------------------------------------
  var name = TextEditingController();
  var phoneNo = TextEditingController();
  var password = TextEditingController();
  var dob = TextEditingController();
  var address = TextEditingController();
  //--------------------------------------
  XFile? avatarPic;
  var isTermsAgreed = false.obs;
}
