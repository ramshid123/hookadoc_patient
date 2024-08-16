import 'package:doctor_app_v2/pages/patient_section/add_medicine_page/addmedicine_index.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMedicineWidgets {
  static Widget pillNameField({required AddMedicineController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(
          text: 'Pills name',
          fontWeight: FontWeight.w500,
        ),
        kHeight(5.h),
        SizedBox(
          height: 50.h,
          child: TextFormField(
            controller: controller.state.pillNameCont,
            decoration: InputDecoration(
              hintText: 'Name of medicine',
              hintStyle: GoogleFonts.getFont(
                'Poppins',
                fontSize: 12.sp,
                color: ColorConstants.mediumGreyH,
              ),
              filled: true,
              fillColor: ColorConstants.lightGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return '*Required';
              return null;
            },
          ),
        ),
      ],
    );
  }

  static Widget descriptionField({required AddMedicineController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(
          text: 'Add note',
          fontWeight: FontWeight.w500,
        ),
        kHeight(5.h),
        SizedBox(
          height: 100.h,
          child: TextFormField(
            controller: controller.state.descriptionCont,
            minLines: 2,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: '2 Tablets, After meal..',
              hintStyle: GoogleFonts.getFont(
                'Poppins',
                fontSize: 12.sp,
                color: ColorConstants.mediumGreyH,
              ),
              filled: true,
              fillColor: ColorConstants.lightGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget amountField({required AddMedicineController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(
          text: 'Amount',
          fontWeight: FontWeight.w500,
        ),
        kHeight(5.h),
        SizedBox(
          height: 50.h,
          width: Get.width / 2 - 40.w,
          child: TextFormField(
            controller: controller.state.amountCont,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Amount',
              hintStyle: GoogleFonts.getFont(
                'Poppins',
                fontSize: 12.sp,
                color: ColorConstants.mediumGreyH,
              ),
              filled: true,
              fillColor: ColorConstants.lightGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return '*Required';
              return null;
            },
          ),
        ),
      ],
    );
  }

  static Widget medicineTypeTile({
    required bool isSelected,
    required AddMedicineController controller,
    required String pillType,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: () {
        controller.state.medicineFormCont.text = pillType;
        controller.update();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        height: 80.h,
        width: 80.h,
        decoration: BoxDecoration(
          color:
              isSelected ? ColorConstants.darkGrey : ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40.r,
              width: 40.r,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                    isSelected
                        ? ColorConstants.mediumGreyL
                        : ColorConstants.darkGrey,
                    BlendMode.srcIn),
                // height: 10.r,
                width: 25.r,
              ),
            ),
            kHeight(5.h),
            kText(
              text: pillType,
              fontSize: 13,
              color: isSelected
                  ? ColorConstants.mediumGreyL
                  : ColorConstants.darkGrey,
            ),
            kHeight(10.h),
          ],
        ),
      ),
    );
  }

  static Widget addTimingButton(
      {required AddMedicineController controller,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () async {
        await controller.showCustomTimePicker(context: context);
      },
      child: Container(
        height: 30.h,
        width: 30.h,
        decoration: BoxDecoration(
          color: ColorConstants.darkGrey,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Icon(
          Icons.add,
          color: ColorConstants.mediumGreyL,
          size: 15.r,
        ),
      ),
    );
  }

  static Widget timingTile(
      {required String time, required AddMedicineController controller}) {
    return GestureDetector(
      onTap: () => controller.state.timings.remove(time),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              kText(text: time),
              Icon(
                Icons.remove_circle,
                size: 15.r,
                color: ColorConstants.darkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget doneButton({required AddMedicineController controller, required BuildContext context}) {
    return GestureDetector(
      onTap: () async => await controller.addMedicine(context: context),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
        height: 50.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstants.darkGrey,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: kText(
            text: 'Done',
            fontSize: 20,
            color: ColorConstants.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
