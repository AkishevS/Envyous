import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';
import '../services/telegram_service.dart' as tg;
import '../controllers/user_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loading = false;
  String? _error;

  String? getInitData() {
    return js.context['Telegram']?['WebApp']?['initData'] as String?;
  }

  int? getChatId() {
    try {
      return tg.initData.initDataUnsafe.user.id;
    } catch (_) {
      return null;
    }
  }

  String? getUsername() {
    try {
      return tg.initData.initDataUnsafe.user.username;
    } catch (_) {
      return null;
    }
  }

  Future<void> _authorize() async {
    final initData = getInitData();
      final chatId = getChatId();
      final username = getUsername();
      if (initData == null || chatId == null || username == null) {
        setState(() => _error = 'Telegram init data not found');
        return;
      }

      setState(() {
        _loading = true;
        _error = null;
      });

      final res = await ApiService.login(initData, chatId, username);
      setState(() => _loading = false);

      if (res != null) {
        UserController.instance.updateFromJson(res);
        if (mounted) context.go('/home');
      } else {
        setState(() => _error = 'Ошибка авторизации');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('Авторизация')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Вход через Telegram WebApp',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading ? null : _authorize,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}