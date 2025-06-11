import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  final String username;
  final bool verified;
  final VoidCallback onSettingsTap;
  final VoidCallback onProfileTap;
  final VoidCallback onHelpTap;

  const HeaderWidget({
    super.key,
    required this.username,
    required this.verified,
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          GestureDetector(
          onTap: onProfileTap,
          child: Row(
            children: [
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage: AssetImage('assets/envyous_logo.png'),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      verified ? 'Verified' : 'Unverified',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

            // Правая часть: настройки и помощь
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onSettingsTap,
                    icon: Icon(Icons.settings, color: Colors.white, size: 18.sp),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 6.w),
                  IconButton(
                    onPressed: onHelpTap,
                    icon: Icon(Icons.help_outline, color: Colors.white, size: 18.sp),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
