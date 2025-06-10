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

class BonusesScreen extends StatelessWidget {
  const BonusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF00FF7F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            'Бонусы',
            style: MTextStyles.primary.copyWith(fontSize: 28.sp),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }
}
