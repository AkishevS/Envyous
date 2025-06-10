import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmingBar extends StatefulWidget {
  const FarmingBar({super.key});

  @override
  State<FarmingBar> createState() => _FarmingBarState();
}

class _FarmingBarState extends State<FarmingBar> {
  double progress = 0.0;
  int remainingSeconds = 0;
  Timer? timer;
  bool isFarming = false;

  void startFarming() {
    if (isFarming) return;

    setState(() {
      isFarming = true;
      remainingSeconds = 180; // 3 минуты
      progress = 0.0;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingSeconds--;
        progress = (180 - remainingSeconds) / 180;

        if (remainingSeconds <= 0) {
          timer.cancel();
          isFarming = false;
          progress = 0.0;
          remainingSeconds = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startFarming,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: isFarming
              ? const LinearGradient(
              colors: [Colors.transparent, Colors.transparent])
              : const LinearGradient(
            colors: [Color(0xFFB066FF), Color(0xFF7A4EF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: isFarming
              ? Border.all(color: Color(0xFFB066FF), width: 2.4)
              : null,
        ),
        child: isFarming
            ? Row(
          children: [
            Text(
              "Farming",
              style: TextStyle(
                color: Color(0xFFB066FF),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Image.asset("assets/envyous_logo_clean.png", width: 16.w),
            SizedBox(width: 4.w),
            Text(
              "${(progress * 2160).toStringAsFixed(1)} / 2160",
              style: TextStyle(
                color: Color(0xFFB066FF),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            const Spacer(),
            Text(
              "${remainingSeconds}s",
              style: TextStyle(
                color: Color(0xFFB066FF),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              "Start Farming",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
