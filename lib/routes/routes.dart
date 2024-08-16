import 'package:doctor_app_v2/pages/login_page/login_index.dart';
import 'package:doctor_app_v2/pages/patient_section/add_medicine_page/addmedicine_index.dart';
import 'package:doctor_app_v2/pages/patient_section/appointment_page/appointment_index.dart';
import 'package:doctor_app_v2/pages/patient_section/booking_success_page/bookingsuccess_index.dart';
import 'package:doctor_app_v2/pages/patient_section/calender_page/calender_index.dart';
import 'package:doctor_app_v2/pages/patient_section/chat_page/chat_index.dart';
import 'package:doctor_app_v2/pages/patient_section/doctor_profile_page/doctorprofile_index.dart';
import 'package:doctor_app_v2/pages/patient_section/doctors_page/doctors_index.dart';
import 'package:doctor_app_v2/pages/patient_section/home_page/home_index.dart';
import 'package:doctor_app_v2/pages/patient_section/map_page/doctormap_index.dart';
import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/mymedicines_index.dart';
import 'package:doctor_app_v2/pages/patient_section/news_section/news_index.dart';
import 'package:doctor_app_v2/pages/sign_up_page/signup_index.dart';
import 'package:doctor_app_v2/pages/sign_up_page/view.dart';
import 'package:doctor_app_v2/pages/splash_screen/splashscreen_index.dart';
import 'package:doctor_app_v2/pages/welcome_page/welcome_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: ApprouteNames.homePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ApprouteNames.doctorsPage,
      page: () => const DoctorsPage(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: ApprouteNames.mapPage,
      page: () => const DoctorMapPage(),
      binding: DoctorMapBinding(),
    ),
    GetPage(
      name: ApprouteNames.doctorProfilePage,
      page: () => const DoctorProfilePage(),
      binding: DoctorProfileBinding(),
    ),
    GetPage(
      name: ApprouteNames.appointmentPage,
      page: () => const AppointMentPage(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: ApprouteNames.chatPage,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: ApprouteNames.welcomePage,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: ApprouteNames.signUpPage,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: ApprouteNames.myMedicinesPage,
      page: () => const MyMedicinesPage(),
      binding: MyMedicinesBinding(),
    ),
    GetPage(
      name: ApprouteNames.bookingSuccessPage,
      page: () => const BookingSuccessPage(),
      binding: BookingSuccessBinding(),
    ),
    GetPage(
      name: ApprouteNames.addMedicinesPage,
      page: () => const AddMedicinePage(),
      binding: AddMedicineBinding(),
    ),
    GetPage(
      name: ApprouteNames.loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: ApprouteNames.splashScreenPage,
      page: () => const SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: ApprouteNames.calenderPage,
      page: () => const CalenderPage(),
      binding: CalenderBinding(),
    ),
    GetPage(
      name: ApprouteNames.newsPage,
      page: () => const NewsPage(),
      binding: NewsBinding(),
    ),
  ];
}
