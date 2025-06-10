import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

Widget buildTopAppBar({
  required String username,
  required String balance,
  VoidCallback? onProfileTap,
  VoidCallback? onSettingsTap,
  VoidCallback? onHelpTap,
}) {
  return Container(
    margin: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(24.r),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Профиль + имя
        GestureDetector(
          onTap: onProfileTap,
          child: Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundImage: AssetImage('assets/avatar_placeholder.png'),
              ),
              SizedBox(width: 8.w),
              Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Баланс
        Row(
          children: [
            Icon(Icons.star, color: MColors.primary, size: 18.sp),
            SizedBox(width: 4.w),
            Text(
              balance,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        // Настройки и помощь
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.grey.shade300, size: 20.sp),
              onPressed: onSettingsTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: 8.w),
            IconButton(
              icon: Icon(Icons.help_outline, color: Colors.grey.shade300, size: 20.sp),
              onPressed: onHelpTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    ),
  );
}
