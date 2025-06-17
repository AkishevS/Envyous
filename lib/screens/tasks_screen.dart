import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Задания',
                style: MTextStyles.primary.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView(
                  children: [
                    _taskItem('🪙', 'Зайти в мини-апп', 20, completed: false),
                    _taskItem('📣', 'Пригласить друга', 50, completed: true),
                    _taskItem('🎯', 'Выполнить 3 клика', 30, completed: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }

  Widget _taskItem(String emoji, String title, int reward,
      {bool completed = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 28.sp)),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: MTextStyles.primary.copyWith(fontSize: 18.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: completed
                  ? Colors.white12
                  : MColors.primary,
              border: completed
                  ? Border.all(color: Colors.white24)
                  : null,
            ),
            child: Text(
              completed ? '✔ Выполнено' : 'Собрать +$reward',
              style: TextStyle(
                color: completed ? Colors.white54 : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
