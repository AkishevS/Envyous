import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../controllers/user_controller.dart';
import '../styles/colors.dart';
import '../widgets/balance_info_bar.dart';
import '../widgets/farming_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_widget.dart';
import 'profile_screen.dart' hide showProfileSheet;
import '../widgets/modals.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int balance = 23691;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  Offset? tapPosition;
  bool showPlusOne = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 170),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.17,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCoinTap(TapDownDetails details) async {
    setState(() {
      balance += 1;
      tapPosition = details.globalPosition;
      showPlusOne = true;
    });
    _controller.forward().then((_) => _controller.reverse());
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => showPlusOne = false);
  }
  void showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MColors.card,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        content: Text(
          'Coming soon',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final coinSize = 200.w;

    final farmingBarBottom = 24.h + 10.h;
    final farmingBarHeight = 70.h;
    final coinBottom = farmingBarBottom + farmingBarHeight + 100;
    final balanceBlockBottom = coinBottom + coinSize + 150;

    return Scaffold(
      backgroundColor: MColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Image.asset('assets/bg_purple.png', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 40.h,
            left: 16.w,
            right: 16.w,
            child: HeaderWidget(
              verified: true,
              username: UserController.instance.username,
              onProfileTap: () => showProfileSheet(context),
              onSettingsTap: () => showSettingsSheet(context),
              onHelpTap: () => showHelpSheet(context),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: balanceBlockBottom,
            child: BalanceBlock(
              balance: balance,
              dollarBalance: 8.05,
              onBalanceTap: () =>  showComingSoonDialog(),
              onTransferTap: () => context.go('/transfers'),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width - coinSize) / 2,
            bottom: coinBottom,
            child: GestureDetector(
              onTapDown: _onCoinTap,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
                child: SizedBox(
                  width: coinSize,
                  height: coinSize,
                  child: Image.asset('assets/envyous_logo_clean.png',
                      fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24.h,
            child: const FarmingBar(),
          ),
          if (showPlusOne && tapPosition != null)
            Positioned(
              top: tapPosition!.dy - 60,
              left: tapPosition!.dx - 20,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: -40),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: 1 - (value.abs() / 40),
                    child: Transform.translate(
                      offset: Offset(0, value),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  '+1',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: MColors.primary,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }
}
