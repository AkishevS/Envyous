import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_widget.dart';
import '../widgets/modals.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static final _players = [
    {'name': 'Akishev', 'score': 1280},
    {'name': 'PlayerTwo', 'score': 1150},
    {'name': 'RedFox', 'score': 980},
    {'name': 'User123', 'score': 810},
    {'name': 'CoolGuy', 'score': 790},
    {'name': 'Runner', 'score': 730},
    {'name': 'Sharp', 'score': 690},
    {'name': 'Nick', 'score': 640},
    {'name': 'Swift', 'score': 610},
    {'name': 'LastOne', 'score': 580},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Image.asset(
                'assets/bg_purple.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  HeaderWidget(
                    verified: true,
                    username: 'Akishev',
                    onProfileTap: () => showProfileSheet(context),
                    onSettingsTap: () => showSettingsSheet(context),
                    onHelpTap: () => showHelpSheet(context),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Таблица лидеров',
                    style: MTextStyles.main.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (context, index) {
                        final p = _players[index];
                        return _leaderboardTile(
                          index + 1,
                          p['name'] as String,
                          p['score'] as int,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  Widget _leaderboardTile(int rank, String username, int score) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: MColors.primary.withOpacity(0.9),
            child: Text(
              '$rank',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            score.toString(),
            style: TextStyle(
              color: MColors.brightPurple,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
