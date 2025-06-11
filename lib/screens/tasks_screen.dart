import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../styles/colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_widget.dart';


int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class DailyRewardsScreen extends StatefulWidget {
  const DailyRewardsScreen({super.key});

  @override
  State<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends State<DailyRewardsScreen> {
  final int currentDay = 1;
  late Timer timer;
  Duration remaining = const Duration(hours: 4, minutes: 55, seconds: 47);
  bool showDaily = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (remaining.inSeconds > 0) {
          remaining = remaining - const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Positioned(
              top: 40.h,
              left: 16.w,
              right: 16.w,
              child: HeaderWidget(
                verified: true,
                username: 'Akishev',
                onSettingsTap: () {},
                onHelpTap: () {},
              ),
            ),
            SizedBox(height: 45.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showDaily = false),
                    child: Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: showDaily ? Colors.transparent : Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Задания',
                        style: TextStyle(
                          color: showDaily ? Colors.white.withOpacity(0.42) : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showDaily = true),
                    child: Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: showDaily ? Colors.white.withOpacity(0.06) : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Ежедневные',
                        style: TextStyle(
                          color: showDaily ? Colors.white : Colors.white.withOpacity(0.42),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            if (showDaily)
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Заходи каждый день и забирай бонус!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: GridView.builder(
                        itemCount: 31,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          int day = index + 1;
                          bool isCollected = day < currentDay;
                          bool isToday = day == currentDay;

                          return GestureDetector(
                            onTap: isToday ? () {} : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12.r),
                                border: isToday
                                    ? Border.all(color: Colors.blueAccent, width: 1.6)
                                    : null,
                              ),
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'День $day',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Image.asset('assets/envyous_logo_clean.png', width: 28.w),
                                  SizedBox(height: 6.h),
                                  Text(
                                    isCollected
                                        ? 'Собрано'
                                        : '+ ${(day * 1000).toString()}🪙',
                                    style: TextStyle(
                                      color: isCollected
                                          ? Colors.white.withOpacity(0.5)
                                          : MColors.primary,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        formatDuration(remaining),
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
                      child: Text(
                        'Социальные сети',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          _taskItem('Подпишись на 1win в Telegram', 19306800),
                          _taskItem('Приручи Мухтара', 25742500),
                          _taskItem('Поставь лайк и сделай ретвит в X', 12871200),
                          _taskItem('Сделай репост Reels в историю Instagram', 12871200),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }

  Widget _taskItem(String title, int reward) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/envyous_logo.png', width: 32.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset('assets/coin.png', width: 14.w),
                    SizedBox(width: 4.w),
                    Text(
                      '+ ${reward.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => "${m[1]} ")} ',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white38),
        ],
      ),
    );
  }
}
