import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconWithText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30.sp, color: Colors.white),
        SizedBox(height: 6.h),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }
}
