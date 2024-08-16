import 'package:doctor_app_v2/routes/names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  static final instance = FirebaseAuth.instance;

  static Future<String> createAccount(
      {required String phone, required String password}) async {
    final snapshot = await instance.createUserWithEmailAndPassword(
        email: '$phone@takeadoc.com', password: password);
    return snapshot.user!.uid;
  }

  static Future<String> login(
      {required String phone, required String password}) async {
    final snapshot = await instance.signInWithEmailAndPassword(
        email: '$phone@takeadoc.com', password: password);
    return snapshot.user!.uid;
  }
}
