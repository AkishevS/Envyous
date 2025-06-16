import 'dart:js' as js;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../controllers/user_controller.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/header_widget.dart';
import '../widgets/modals.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<dynamic> _referrals = [];
  bool _loading = true;

  String? getInitData() {
    return js.context['Telegram']?['WebApp']?['initData'] as String?;
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final initData = getInitData();
    if (initData == null) return;

    final data = await ApiService.fetchReferrals(initData);
    setState(() {
      _referrals = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 40.h),
            HeaderWidget(
              verified: true,
              username: UserController.instance.username,
              onProfileTap: () => showProfileSheet(context),
              onSettingsTap: () => showSettingsSheet(context),
              onHelpTap: () => showHelpSheet(context),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Column(
                children: [
                  Text(
                    '+10% от их заработка',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  Text(
                    '${_referrals.length}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Друзья',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Посмотреть правила реферальной программы >',
                    style:
                    TextStyle(color: Colors.purpleAccent, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _loading
                    ? [
                  const Center(child: CircularProgressIndicator()),
                ]
                    : _referrals.map((ref) {
                  return Column(
                    children: [
                      FriendTile(
                        rank: 0,
                        username: 'ID ${ref['telegram_id']}',
                        date: ref['registered_at']?.toString() ?? '',
                      ),
                      SizedBox(height: 12.h),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r)),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              onPressed: () {
                final userId = js.context['Telegram']?['WebApp']?['initDataUnsafe']?['user']?['id'];
                if (userId != null) {
                  final link = 'https://t.me/YourBot/yourApp?startapp=$userId';
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Text('Скопируй и отправь другу: $link'),
                    ),
                  );
                }
              },
              child: Text(
                'Пригласить друга',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final int rank;
  final String username;
  final String date;

  const FriendTile({
    super.key,
    required this.rank,
    required this.username,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 18.r,
          backgroundColor: Colors.purple,
          child: Text(username.substring(0, 1),
              style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              Text(date,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 11.sp)),
            ],
          ),
        ),
        Text('+10% 🟡', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      ],
    );
  }
}