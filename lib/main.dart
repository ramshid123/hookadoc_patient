import 'package:doctor_app_v2/firebase_options.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/routes/routes.dart';
import 'package:doctor_app_v2/services/auth_service.dart';
import 'package:doctor_app_v2/services/hive_service.dart';
import 'package:doctor_app_v2/services/local_notification_service.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await HiveServices.initHive();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ZIMKit().init(
    appID: 743866155,
    appSign: '7d597da08c984ffeb4720b5501c232336b7a1ba696e41a21b3a17de49d99e1f3',
    appSecret: 'fc4ae8886169eb7979867b6532e6cc08',
  );
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 732),
        builder: (context, _) {
          return GetMaterialApp(
            defaultTransition: Transition.native,
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: ColorConstants.darkGrey,
              primarySwatch: const MaterialColor(
                0xff2f3449,
                <int, Color>{
                  50: Color(0xff4e5161),
                  100: Color(0xff4e5161),
                  200: Color(0xff4e5161),
                  300: Color(0xff4e5161),
                  400: Color(0xff4e5161),
                  500: Color(0xff4e5161),
                  600: Color(0xff4e5161),
                  700: Color(0xff4e5161),
                  800: Color(0xff4e5161),
                  900: Color(0xff4e5161),
                },
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'takeADoc',
            // initialRoute: ApprouteNames.splashScreenPage,
            initialRoute: ApprouteNames.splashScreenPage,
            getPages: AppRoutes.routes,
          );
        });
  }
}
