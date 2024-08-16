import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/widgets.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/bottom_nav_bar.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyMedicinesPage extends GetView<MyMedicinesController> {
  const MyMedicinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.offAllNamed(ApprouteNames.homePage),
      child: Scaffold(
        bottomNavigationBar: kBottomNavigationBar(index: 2),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async =>
                        await Get.offAllNamed(ApprouteNames.homePage),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorConstants.darkGrey,
                      size: 35.r,
                    ),
                  ),
                  kText(
                    text: 'My Medicines',
                    color: ColorConstants.darkGrey,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(),
                ],
              ),
              kHeight(20.h),
              Row(
                children: [
                  MyMedicinesWidgets.searchBar(),
                  const Spacer(),
                  MyMedicinesWidgets.addMedicineButton(controller: controller),
                ],
              ),
              kHeight(20.h),
              Obx(() {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.state.medicineList.length,
                      itemBuilder: (context, index) {
                        final medicineItem =
                            controller.state.medicineList[index];
                        return MyMedicinesWidgets.medicineTile(
                          context: context,
                          controller: controller,
                          medicine: medicineItem,
                        );
                      }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
