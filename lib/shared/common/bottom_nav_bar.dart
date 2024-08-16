import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget kBottomNavigationBar({required int index}) {
  return SizedBox(
    height: 50.h,
    width: Get.width,
    // color: Colors.red,
    child: Column(
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            kBottomNavBarItem(
              isSelected: index == 0,
              selectedIcon: Icons.home,
              unselectedIcon: Icons.home_outlined,
              routeName: ApprouteNames.homePage,
            ),
            kBottomNavBarItem(
              isSelected: index == 1,
              selectedIcon: Icons.calendar_today,
              unselectedIcon: Icons.calendar_today_outlined,
              routeName: ApprouteNames.calenderPage,
            ),
            kBottomNavBarItem(
              isSelected: index == 2,
              selectedIcon: Icons.medication,
              unselectedIcon: Icons.medication_outlined,
              routeName: ApprouteNames.myMedicinesPage,
            ),
            kBottomNavBarItem(
              isSelected: index == 3,
              selectedIcon: Icons.feed,
              unselectedIcon: Icons.feed_outlined,
              routeName: ApprouteNames.newsPage,
            ),
            kBottomNavBarItem(
              isSelected: index == 4,
              selectedIcon: Icons.notifications,
              unselectedIcon: Icons.notifications_outlined,
              routeName: ApprouteNames.homePage,
            ),
          ],
        ),
        const Spacer(),
      ],
    ),
  );
}

Widget kBottomNavBarItem({
  required bool isSelected,
  required IconData selectedIcon,
  required IconData unselectedIcon,
  required String routeName,
}) {
  return GestureDetector(
    onTap: () async => await Get.offAllNamed(routeName),
    child: Column(
      children: [
        Icon(
          isSelected ? selectedIcon : unselectedIcon,
          size: 30.r,
          color: ColorConstants.darkGrey,
        )
      ],
    ),
  );
}
