import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  static const List<Map<String, String>> items = [
    {'icon': 'assets/mates.png',   'route': '/friends'},
    {'icon': 'assets/tasks.png',   'route': '/tasks'},
    {'icon': 'assets/home.png',    'route': '/home'},
    {'icon': 'assets/top.png', 'route': '/bonuses'},
    {'icon': 'assets/wallet.png',  'route': '/wallet'},
  ];

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int? _animatingIndex;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _opacity =
  Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index, String route, bool isSelected) async {
    if (!isSelected) {
      setState(() => _animatingIndex = index);
      await Future.delayed(const Duration(milliseconds: 150));
      setState(() => _animatingIndex = null);
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.grey.shade800, width: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(BottomNavBar.items.length, (index) {
          final item = BottomNavBar.items[index];
          final isSelected = index == widget.currentIndex;
          final isAnimating = index == _animatingIndex;

          return GestureDetector(
            onTap: () => _onTap(index, item['route']!, isSelected),
            child: AnimatedScale(
              scale: isAnimating
                  ? 1.17
                  : isSelected
                  ? 1.07
                  : 1.0,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon']!,
                    width: 46.w, // увеличим, т.к. иконка с надписью
                    height: 46.w,
                  ),
                  SizedBox(height: 6.h),
                  FadeTransition(
                    opacity: isSelected ? _opacity : kAlwaysDismissedAnimation,
                    child: Container(
                      width: 28.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
