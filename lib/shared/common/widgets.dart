import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kText({
  required String text,
  Color color = ColorConstants.darkGrey,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 1,
  TextAlign textAlign = TextAlign.start,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.getFont(
      'Poppins',
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget kHeight(double height) {
  return SizedBox(height: height);
}

Widget kWidth(double width) {
  return SizedBox(width: width);
}
