import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class TokensScreen extends StatelessWidget {
  const TokensScreen({super.key});

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
            'Tokens',
            style: MTextStyles.primary.copyWith(fontSize: 28.sp),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}
