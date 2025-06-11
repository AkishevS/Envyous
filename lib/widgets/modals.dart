import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key});

  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet> {
  static const List<String> _avatars = [
    'assets/bg_purple.png',
    'assets/bonuses.png',
    'assets/envyous_black_coin.png',
    'assets/envyous_coin.png',
    'assets/envyous_logo.png',
    'assets/envyous_logo_clean.png',
    'assets/envyous_tap.png',
    'assets/home.png',
    'assets/mates.png',
    'assets/tasks.png',
    'assets/top.png',
    'assets/wallet.png',
  ];

  String _selected = _avatars.first;
  final int _position = 7; // placeholder leaderboard position

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, bottomPadding + 16.h),
      decoration: BoxDecoration(
        color: MColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage(_selected),
              radius: 36.r,
            ),
            SizedBox(height: 12.h),
            Text('You are #$_position in the leaderboard',
                style: MTextStyles.main),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Choose avatar', style: MTextStyles.secondary),
            ),
            SizedBox(height: 8.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _avatars.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
              ),
              itemBuilder: (context, index) {
                final path = _avatars[index];
                final isSelected = path == _selected;
                return GestureDetector(
                  onTap: () => setState(() => _selected = path),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: MColors.primary, width: 2)
                          : null,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(path),
                      radius: 24.r,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showProfileSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.9,
      child: const ProfileSheet(),
    ),
  );
}

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, bottomPadding + 16.h),
      decoration: BoxDecoration(
        color: MColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Text('Settings', style: MTextStyles.main),
          SizedBox(height: 12.h),
          Text('Coming soon', style: MTextStyles.secondary),
        ],
      ),
    );
  }
}

void showSettingsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.8,
      child: const SettingsSheet(),
    ),
  );
}

class HelpSheet extends StatelessWidget {
  const HelpSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, bottomPadding + 16.h),
      decoration: BoxDecoration(
        color: MColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Text('Help', style: MTextStyles.main),
          SizedBox(height: 12.h),
          Text('Coming soon', style: MTextStyles.secondary),
        ],
      ),
    );
  }
}

void showHelpSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.8,
      child: const HelpSheet(),
    ),
  );
}