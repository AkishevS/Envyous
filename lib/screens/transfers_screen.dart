import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Image.asset('assets/bg_purple.png', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Переводы',
                    style: MTextStyles.primary.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.r),
                        gradient: LinearGradient(
                          colors: [MColors.primary, MColors.brightPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MColors.primary.withOpacity(0.10),
                            blurRadius: 11,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sync_alt_rounded,
                              color: Colors.white, size: 15.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Transfer points',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              letterSpacing: 0.1,
                              shadows: [
                                Shadow(
                                  color: Colors.blueAccent.withOpacity(0.10),
                                  blurRadius: 6,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'История переводов',
                    style: MTextStyles.primary.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Пример 1
                  _transferCard(
                    context,
                    username: 'RedFox',
                    date: 'Сегодня, 14:30',
                    amount: '-120 E',
                  ),
                  // Пример 2
                  _transferCard(
                    context,
                    username: 'Akishev',
                    date: 'Вчера, 18:00',
                    amount: '-75 E',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }

  Widget _transferCard(BuildContext context,
      {required String username,
      required String date,
      required String amount}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: MColors.primary.withOpacity(0.15),
            child:
                Icon(Icons.account_circle, color: MColors.primary, size: 30.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: MTextStyles.primary.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: MTextStyles.secondary.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: MTextStyles.primary.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: MColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
