import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

class TaskItem extends StatelessWidget {
  final String iconPath;           // путь до фотки/иконки задания
  final String title;              // текст задания
  final String reward;             // например: '+12 871 200'
  final String coinIconPath;       // путь до иконки монеты
  final List<Widget>? rightIcons;  // список иконок справа (например, VK, Telegram)
  final VoidCallback? onTap;       // действие при нажатии

  const TaskItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.reward,
    required this.coinIconPath,
    this.rightIcons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: const Color(0xFF18181B), // черный с серым оттенком
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            // Иконка слева
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                iconPath,
                width: 38.w,
                height: 38.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 13.w),
            // Текст + награда
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Image.asset(
                        coinIconPath,
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        reward,
                        style: TextStyle(
                          color: MColors.primary, // ярко-жёлтый
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                      ),
                      if (rightIcons != null)
                        ...rightIcons!,
                    ],
                  ),
                ],
              ),
            ),
            // Стрелка справа
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 22.sp),
          ],
        ),
      ),
    );
  }
}
