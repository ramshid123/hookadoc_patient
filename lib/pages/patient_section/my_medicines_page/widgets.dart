import 'package:doctor_app_v2/models/medicine_model.dart';
import 'package:doctor_app_v2/pages/patient_section/my_medicines_page/mymedicines_index.dart';
import 'package:doctor_app_v2/routes/names.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyMedicinesWidgets {
  static Widget searchBar() {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            color: ColorConstants.lightGrey,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10.r)),
          ),
          child: Icon(
            Icons.search,
            color: ColorConstants.mediumGreyH,
            size: 30.r,
          ),
        ),
        SizedBox(
          height: 40.h,
          width: Get.width - 40.w - 60.w - 50.w,
          child: Center(
            child: TextFormField(
              style: TextStyle(
                fontSize: 20.sp,
                color: ColorConstants.darkGrey,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorConstants.lightGrey,
                hintText: 'Search Medicine',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ColorConstants.mediumGreyH,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10.r)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget addMedicineButton({required MyMedicinesController controller}) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(ApprouteNames.addMedicinesPage);
        await controller.getAllMedicines();
      },
      child: Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          color: ColorConstants.darkGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 20.r,
            color: ColorConstants.whiteColor,
          ),
        ),
      ),
    );
  }

  static Widget medicineTile({
    required MedicineModel medicine,
    required MyMedicinesController controller,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () async => await controller.showMedicineDetails(
          context: context, medicine: medicine),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 40.h,
              width: 50.w,
              child: SvgPicture.asset(
                controller.state.iconMappingData[medicine.medicineForm]!,
                colorFilter: const ColorFilter.mode(
                    ColorConstants.darkGrey, BlendMode.srcIn),
                fit: BoxFit.contain,
              ),
            ),
            kWidth(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kText(
                    maxLines: 1,
                    text: medicine.pillName,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  kHeight(5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: ColorConstants.mediumGreyH,
                        size: 25.r,
                      ),
                      kWidth(10.w),
                      Expanded(
                        child: Wrap(
                          children: [
                            for (var time in medicine.timings)
                              kText(
                                text: '$time   |   ',
                                maxLines: 1,
                                color: ColorConstants.mediumGreyH,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                  kHeight(5.h),
                  kText(
                    text: medicine.description.isEmpty
                        ? '$medicine.amount left'
                        : medicine.description,
                    color: ColorConstants.mediumGreyH,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget timingTile(
      {required String time, required MyMedicinesController controller}) {
    return GestureDetector(
      // onTap: () => controller.state.timings.remove(time),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: kText(text: time),
        ),
      ),
    );
  }
}

class TemporaryContainer extends StatelessWidget {
  final MedicineModel medicine;
  final MyMedicinesController controller;
  const TemporaryContainer(
      {super.key, required this.medicine, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        border: Border.all(
          color: ColorConstants.darkGrey,
          width: 5.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorConstants.darkGrey,
                      size: 30.r,
                    ),
                  ),
                  kText(
                    text: 'Edit',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              kHeight(20.h),
              Row(
                children: [
                  Container(
                    height: 80.r,
                    width: 80.r,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        controller
                            .state.iconMappingData[medicine.medicineForm]!,
                        height: 50.r,
                        width: 50.r,
                        colorFilter: const ColorFilter.mode(
                            ColorConstants.darkGrey, BlendMode.srcIn),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  kWidth(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kText(
                        text: medicine.pillName,
                        maxLines: 5,
                        color: ColorConstants.darkGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      kHeight(5.h),
                      kText(
                        text: medicine.description,
                        maxLines: 5,
                        color: ColorConstants.mediumGreyH,
                      ),
                    ],
                  ),
                ],
              ),
              kHeight(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 65.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'Start date',
                          color: ColorConstants.mediumGreyH,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        kHeight(5.h),
                        kText(
                          text: controller.convertDateRaw2Readable(
                              rawDate: medicine.startDate),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 65.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'Inventory',
                          color: ColorConstants.mediumGreyH,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        kHeight(5.h),
                        kText(
                          text: controller.calculateInventory(
                              startDateString: medicine.startDate,
                              amountString: medicine.amount,
                              numOfDose: medicine.timings.length),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              kHeight(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 65.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'Duration',
                          color: ColorConstants.mediumGreyH,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        kHeight(5.h),
                        kText(
                          text: controller.calculateDuration(
                              startDateString: medicine.startDate,
                              amountString: medicine.amount,
                              numOfDose: medicine.timings.length),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 65.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGrey,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'End date',
                          color: ColorConstants.mediumGreyH,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        kHeight(5.h),
                        kText(
                          text: controller.calculateLastDate(
                              startDateString: medicine.startDate,
                              amountString: medicine.amount,
                              numOfDose: medicine.timings.length),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              kHeight(20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: kText(
                  text: 'Medicine Time',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              kHeight(15.h),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
              //   height: 50.h,
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //     color: ColorConstants.lightGrey,
              //     borderRadius: BorderRadius.circular(15.r),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Icon(
              //         Icons.timer,
              //         color: ColorConstants.darkGrey,
              //         size: 30.r,
              //       ),
              //       kText(
              //         text: medicine.timings.first,
              //         fontSize: 20,
              //         fontWeight: FontWeight.w500,
              //       ),
              //       Icon(
              //         Icons.timer,
              //         color: Colors.transparent,
              //         size: 30.r,
              //       ),
              //     ],
              //   ),
              // ),
              Wrap(
                spacing: 10.w,
                children: [
                  for (var time in medicine.timings)
                    MyMedicinesWidgets.timingTile(
                        time: time, controller: controller),
                ],
              ),
              kHeight(30.h),
              GestureDetector(
                onTap: () async =>
                    await controller.deleteMedicineByTime(id: medicine.id),
                child: Container(
                  height: 50.h,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    color: ColorConstants.darkGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: ColorConstants.lightGrey,
                        size: 30.r,
                      ),
                      kWidth(10.w),
                      kText(
                        text: 'Delete',
                        color: ColorConstants.lightGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
