import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class MTextStyles {
  static final TextStyle main = TextStyle(
    color: MColors.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle primary = TextStyle(
    color: MColors.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle secondary = TextStyle(
    color: MColors.secondaryText,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
