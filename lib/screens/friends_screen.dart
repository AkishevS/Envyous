import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_widget.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            SizedBox(height: 24.h),
            Center(),
            SizedBox(height: 24.h),
            Center(
              child: Column(
                children: [
                  Text(
                    '+0',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  Text(
                    '14',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Друзья',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Посмотреть правила реферальной программы >',
                    style:
                        TextStyle(color: Colors.purpleAccent, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FriendTile(rank: 1, username: '@_@', date: '2024.10.20'),
                  SizedBox(height: 12.h),
                  FriendTile(rank: 2, username: 'Arsyk', date: '2024.10.09'),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              onPressed: () {
                // действие на "пригласить"
              },
              child: Text(
                'Пригласить друга',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final int rank;
  final String username;
  final String date;

  const FriendTile({
    super.key,
    required this.rank,
    required this.username,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 18.r,
          backgroundColor: Colors.purple,
          child: Text(username.substring(0, 1),
              style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              Text(date,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 11.sp)),
            ],
          ),
        ),
        Text('+0 🟡', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      ],
    );
  }
}
