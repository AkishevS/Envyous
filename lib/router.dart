import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/transfers_screen.dart';
import 'screens/friends_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/auth',
      name: 'auth',
      pageBuilder: (_, __) => NoTransitionPage(child: const AuthScreen()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (_, __) => NoTransitionPage(child: const HomeScreen()),
    ),
    GoRoute(
      path: '/wallet',
      name: 'wallet',
      pageBuilder: (_, __) => NoTransitionPage(child: const WalletScreen()),
    ),
    GoRoute(
      path: '/tasks',
      name: 'tasks',
      pageBuilder: (_, __) => NoTransitionPage(child: const DailyRewardsScreen()),
    ),
    GoRoute(
      path: '/bonuses',
      name: 'bonuses',
      pageBuilder: (_, __) => NoTransitionPage(child: const LeaderboardScreen()),
    ),
    GoRoute(
      path: '/transfers',
      name: 'transfers',
      pageBuilder: (_, __) => NoTransitionPage(child: const TransfersScreen()),
    ),
    GoRoute(
      path: '/friends',
      name: 'friends',
      pageBuilder: (_, __) => NoTransitionPage(child: const FriendsScreen()),
    ),
  ],
);

class NoTransitionPage extends CustomTransitionPage<void> {
  NoTransitionPage({required super.child})
      : super(
    transitionsBuilder: (_, __, ___, child) => child,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}