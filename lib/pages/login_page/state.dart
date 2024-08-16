import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState {
  final formKey = GlobalKey<FormState>();

  final phoneNo = TextEditingController();
  final password = TextEditingController();

  var isLoading = false.obs;
}
