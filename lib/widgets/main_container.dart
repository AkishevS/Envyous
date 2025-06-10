import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import 'bottom_nav_bar.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    super.key,
    required this.children,
    this.showFooter = true,
    this.currentIndex = 0,
  });

  final List<Widget> children;
  final bool showFooter;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MColors.card,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30).r,
            topRight: Radius.circular(30).r,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 32.h, bottom: 100.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [...children],
              ),
            ),
            if (showFooter)
              BottomNavBar(currentIndex: currentIndex),
          ],
        ),
      ),
    );
  }
}
