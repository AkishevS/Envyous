import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class BalanceBlock extends StatelessWidget {
  final int balance;
  final double dollarBalance;
  final VoidCallback onBalanceTap;
  final VoidCallback onTransferTap;

  const BalanceBlock({
    super.key,
    required this.balance,
    required this.dollarBalance,
    required this.onBalanceTap,
    required this.onTransferTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MColors.primary.withOpacity(0.6),
                    blurRadius: 11,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [MColors.primary, MColors.brightPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/envyous_logo_clean.png',
                  width: 22.w,
                  height: 22.w,
                ),
              ),
            ),
            SizedBox(width: 11.w),
            Text(
              '${balance.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ' ')}',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onBalanceTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                margin: EdgeInsets.only(right: 11.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [MColors.primary, MColors.brightPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(17.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.25),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 15.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Boosters',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.sp,
                        letterSpacing: 0.2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onTransferTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.r),
                  gradient: LinearGradient(
                    colors: [
                      MColors.primary,
                      MColors.brightPurple
                    ],
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
                    Icon(Icons.sync_alt_rounded, color: Colors.white, size: 15.sp),
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
          ],
        ),
      ],
    );
  }
}
