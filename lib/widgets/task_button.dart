import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

enum ButtonType { primary, secondary, disabled }

class TaskButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;

  const TaskButton({required this.label, this.onPressed, this.type = ButtonType.primary, super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type) {
      case ButtonType.primary:
        bgColor = MColors.primary;
        textColor = Colors.black;
        break;
      case ButtonType.secondary:
        bgColor = Colors.white;
        textColor = Colors.black;
        break;
      case ButtonType.disabled:
        bgColor = Colors.transparent;
        textColor = Colors.grey;
        break;
    }

    return GestureDetector(
      onTap: type != ButtonType.disabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: type == ButtonType.disabled
              ? Border.all(color: Colors.grey, width: 1)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
