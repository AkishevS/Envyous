import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[800],
          radius: 26.r,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
      ],
    );
  }
}
