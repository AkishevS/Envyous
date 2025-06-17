import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final players = [
      {'name': 'Akishev', 'score': 1280},
      {'name': 'RedFox', 'score': 1150},
      {'name': 'PlayerTwo', 'score': 980},
    ];

    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Таблица лидеров',
                style: MTextStyles.primary.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  itemCount: players.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '#${index + 1}',
                            style: MTextStyles.primary.copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'name',
                              style: MTextStyles.primary.copyWith(fontSize: 18.sp),
                            ),
                          ),
                          Text(
                            '${player['score']} E',
                            style: MTextStyles.primary.copyWith(
                              fontSize: 18.sp,
                              color: MColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}
