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

  @override
  void initState() {
  super.initState();
  _load();
  }

  Future<void> _load() async {
  final data = await ApiService.fetchLeaderboard();
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
  title: Text(u['username'] ?? '', style: MTextStyles.main),
  trailing:
  Text('${u['balance']}', style: MTextStyles.primary),
  );
  },
  ),
  ),
  bottomNavigationBar: BottomNavBar(currentIndex: 0),
  );
  }
  }