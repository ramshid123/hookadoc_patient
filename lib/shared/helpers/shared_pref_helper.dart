import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelpers {
  static const String uid = 'uid';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String medicineNotificationId =
      'last_saved_medicine_notification_id';
  static const String isThisTheFirstTimeToThisApp =
      'is_this_the_first_time_to_this_app';

  static Future setValue({required String key, required String value}) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString(key, value);
  }

  static Future<String?> getValue({required String key}) async {
    final sf = await SharedPreferences.getInstance();
    return sf.getString(key);
  }

  static Future<bool?> getBoolValue({required String key}) async {
    final sf = await SharedPreferences.getInstance();
    return sf.getBool(key);
  }

  static Future setBoolValue({required String key, required bool value}) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setBool(key, value);
  }
}
