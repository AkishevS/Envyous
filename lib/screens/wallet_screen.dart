import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/envyous_logo_clean.png', width: 16.w),
                      SizedBox(width: 6.w),
                      Text('UQC...r8H',
                          style: TextStyle(
                              color: Colors.white, fontSize: 13.sp)),
                      Icon(Icons.arrow_drop_down, color: Colors.white, size: 16.sp),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),

            Text(
              '\$0.01',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),

            // Кнопки
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _walletAction(Icons.arrow_upward, 'Отправить'),
                  _walletAction(Icons.credit_card, 'Buy'),
                  _walletAction(Icons.access_time, 'История'),
                  _walletAction(Icons.auto_awesome, 'Поинты'),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Серый блок с описанием
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/envyous_logo_clean.png', width: 24.w),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Здесь отображены только TON токены. Другие токены не могут быть потрачены здесь.',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12.sp),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white54, size: 18.sp),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Список токенов
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  _walletTokenItem(
                    name: 'Toncoin',
                    subtitle: '< 0.01 TON',
                    amount: '\$0.01',
                    icon: 'assets/envyous_logo_clean.png',
                  ),
                  _walletTokenItem(
                    name: 'Tether USD',
                    subtitle: '0 USD₮',
                    amount: '\$0',
                    icon: 'assets/envyous_logo_clean.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }

  Widget _walletAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20.sp),
        ),
        SizedBox(height: 6.h),
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
      ],
    );
  }

  Widget _walletTokenItem({
    required String name,
    required String subtitle,
    required String amount,
    required String icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Image.asset(icon, width: 32.w, height: 32.w),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              Text(subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12.sp)),
            ],
          ),
          Spacer(),
          Text(amount,
              style:
              TextStyle(color: Colors.white, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
