import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav_bar.dart';

int getCurrentNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  final items = BottomNavBar.items;
  final idx = items.indexWhere((item) => location == item['route']);
  return idx != -1 ? idx : 2;
}