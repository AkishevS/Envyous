import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/api_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<dynamic> _users = [];
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

    final data = await ApiService.fetchLeaderboard(initData);
    setState(() {
      _users = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.background,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            final u = _users[index];
            return ListTile(
              title: Text(
                'ID: ${u['telegram_id']}',
                style: MTextStyles.main,
              ),
              trailing: Text(
                '${u['invites_count']} 👥',
                style: MTextStyles.primary,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}