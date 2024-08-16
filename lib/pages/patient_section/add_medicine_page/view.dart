import 'package:doctor_app_v2/pages/patient_section/add_medicine_page/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/add_medicine_page/widgets.dart';
import 'package:doctor_app_v2/services/local_notification_service.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddMedicinePage extends GetView<AddMedicineController> {
  const AddMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await NotificationService().flutterLocalNotificationsPlugin.cancelAll();
        await NotificationService().showNotification();
      }),
      bottomNavigationBar: AddMedicineWidgets.doneButton(
          controller: controller, context: context),
      body: SingleChildScrollView(
        child: Form(
          key: controller.state.formkey,
          child: Column(
            children: [
              kHeight(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorConstants.darkGrey,
                        size: 35.r,
                      ),
                    ),
                    kText(
                      text: 'Add Medicine',
                      color: ColorConstants.darkGrey,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(),
                  ],
                ),
              ),
              kHeight(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddMedicineWidgets.pillNameField(controller: controller),
                    kHeight(20.h),
                    AddMedicineWidgets.amountField(controller: controller),
                    kHeight(20.h),
                    AddMedicineWidgets.descriptionField(controller: controller),
                  ],
                ),
              ),
              // kHeight(20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: kText(
                    text: 'Medicine form',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              kHeight(10.h),
              GetBuilder(
                  init: controller,
                  builder: (controller) {
                    return SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.state.pillTypes.length,
                        itemBuilder: (context, index) =>
                            AddMedicineWidgets.medicineTypeTile(
                          isSelected: controller.state.pillTypes[index]
                                  ['name'] ==
                              controller.state.medicineFormCont.text,
                          controller: controller,
                          iconPath: controller.state.pillTypes[index]['path']!,
                          pillType: controller.state.pillTypes[index]['name']!,
                        ),
                      ),
                    );
                  }),
              kHeight(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        kText(
                          text: 'Timings',
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        AddMedicineWidgets.addTimingButton(
                            context: context, controller: controller),
                      ],
                    ),
                    kHeight(10.h),
                    Obx(() {
                      return controller.state.timings.isEmpty
                          ? Row(
                              children: [
                                const Spacer(),
                                kText(text: 'Add some timings.'),
                                SizedBox(
                                  height: 20.h,
                                  width: 110.w,
                                  child: SvgPicture.asset(
                                    'assets/others/arrow_right_up.svg',
                                    fit: BoxFit.fill,
                                    height: 20.h,
                                    // width: 110.w,
                                    colorFilter: const ColorFilter.mode(
                                        ColorConstants.darkGrey,
                                        BlendMode.srcIn),
                                  ),
                                ),
                                kWidth(7.w),
                              ],
                            )
                          : Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: [
                                for (var time in controller.state.timings)
                                  AddMedicineWidgets.timingTile(
                                      time: time, controller: controller),
                              ],
                            );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
