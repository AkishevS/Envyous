import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../styles/colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/api_service.dart';
import '../widgets/header_widget.dart';
import '../widgets/modals.dart';
import '../controllers/user_controller.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool showDaily = false;
  List<dynamic> generalTasks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchGeneralTasks();
  }

  Future<void> _fetchGeneralTasks() async {
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/tasks/general'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': ApiService.apiKey,
      },
    );
    if (res.statusCode == 200) {
      setState(() {
        generalTasks = jsonDecode(res.body);
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            HeaderWidget(
              verified: true,
              username: UserController.instance.username,
              onProfileTap: () => showProfileSheet(context),
              onSettingsTap: () => showSettingsSheet(context),
              onHelpTap: () => showHelpSheet(context),
            ),
            SizedBox(height: 45.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showDaily = false),
                    child: Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: showDaily ? Colors.transparent : Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Задания',
                        style: TextStyle(
                          color: showDaily ? Colors.white.withOpacity(0.42) : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showDaily = true),
                    child: Container(
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: showDaily ? Colors.white.withOpacity(0.06) : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18.r),
                          bottomRight: Radius.circular(18.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Ежедневные',
                        style: TextStyle(
                          color: showDaily ? Colors.white : Colors.white.withOpacity(0.42),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : showDaily
                  ? _buildDailyTasks()
                  : _buildGeneralTasks(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: getCurrentNavBarIndex(context),
      ),
    );
  }

  Widget _buildGeneralTasks() {
    return ListView.builder(
      itemCount: generalTasks.length,
      itemBuilder: (context, index) {
        final task = generalTasks[index];
        return _taskItem(
          task['name'] as String,
          task['reward'] as int,
        );
      },
    );
  }

  Widget _buildDailyTasks() {
    final now = DateTime.now();
    final currentDay = now.day;

    return Column(
      children: [
        Text(
          'Заходи каждый день и забирай бонус!',
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14.sp),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: GridView.builder(
            itemCount: 31,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              int day = index + 1;
              bool isCollected = day < currentDay;
              bool isToday = day == currentDay;

              return GestureDetector(
                onTap: isToday ? () {} : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: isToday ? Border.all(color: Colors.blueAccent, width: 1.6) : null,
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('День $day', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                      SizedBox(height: 6.h),
                      Image.asset('assets/envyous_logo_clean.png', width: 28.w),
                      SizedBox(height: 6.h),
                      Text(
                        isCollected ? 'Собрано' : '+ ${(day * 1000)} 🪙',
                        style: TextStyle(
                          color: isCollected ? Colors.white.withOpacity(0.5) : MColors.primary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _taskItem(String title, int reward) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Image.asset('assets/envyous_logo.png', width: 32.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset('assets/coin.png', width: 14.w),
                    SizedBox(width: 4.w),
                    Text(
                      '+ ${reward.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => "\${m[1]} ")} ',
                      style: TextStyle(fontSize: 13.sp, color: Colors.purpleAccent),
                    ),
                  ],
                )
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white38),
        ],
      ),
    );
  }
}
