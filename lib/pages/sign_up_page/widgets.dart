import 'package:doctor_app_v2/pages/sign_up_page/signup_index.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpWidgets {
  static Widget kTextFormWithTitle({
    required String title,
    SignUpController? controller,
    required BuildContext context,
    required TextEditingController textController,
    required String hintText,
    required String
        type, // text OR phone OR date OR password OR address OR number
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(text: title, fontSize: 16),
        kHeight(10.h),
        TextFormField(
          controller: textController,
          obscureText: type == "password" ? true : false,
          inputFormatters: type == "number" || type == "phone"
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          readOnly: type == "date",
          maxLines: type == "address" ? 2 : 1,
          keyboardType: type == "number" || type == "phone"
              ? TextInputType.number
              : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: type == "phone"
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kWidth(10.w),
                      kText(text: '+91', color: Colors.blueGrey),
                      kWidth(5.w),
                      Container(
                        height: 16.h,
                        width: 3.w,
                        decoration: BoxDecoration(
                          color: ColorConstants.darkGrey,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      kWidth(5.w),
                    ],
                  )
                : null,
            suffixIcon: type == "date"
                ? GestureDetector(
                    onTap: () async => controller != null
                        ? await controller.selectDate(context)
                        : print('no controllers passed to textformfield.'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 16.h,
                          width: 3.w,
                          decoration: BoxDecoration(
                            color: ColorConstants.darkGrey,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        kWidth(10.w),
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blueGrey,
                          size: 25.r,
                        ),
                      ],
                    ),
                  )
                : null,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: ColorConstants.darkGrey,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: ColorConstants.darkGrey,
                width: 5.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: ColorConstants.darkGrey,
                width: 2.w,
              ),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty)
              return "*Required";
            else if (type == "phone" && !GetUtils.isPhoneNumber(val))
              return "Phone number is invalid";
            else if (type == "password" && val.length < 8)
              return "Atleast 8 charecters.";
            return null;
          },
        ),
      ],
    );
  }

  static Widget kNextOrContinueButton({
    required VoidCallback onTap,
    required String text,
    Color? color,
  }) {
    color = color ?? ColorConstants.darkGrey;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: color,
            width: 7.w,
          ),
        ),
        child: Center(
          child: kText(
            text: text,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  static Widget kDivider({required Axis direction, required int number}) {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        direction: direction,
        children: [
          for (int i = 0; i < number; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 7.h),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: ColorConstants.mediumGreyL,
              ),
            )
        ],
      ),
    );
  }
}
