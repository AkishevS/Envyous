import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            'Leaderboard страница',
            style: MTextStyles.main.copyWith(fontSize: 22.sp),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
