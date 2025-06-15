import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';
import '../controllers/user_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
  }

  class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
  setState(() {
  _loading = true;
  _error = null;
  });
  final res = await ApiService.login(
  _usernameController.text,
  _passwordController.text,
  );
  setState(() => _loading = false);
  if (res != null) {
  UserController.instance.updateFromJson(res);
  if (mounted) context.go('/home');
  } else {
  setState(() => _error = 'Login failed');
  }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: const Text('Login')),
  body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
  children: [
  TextField(
  controller: _usernameController,
  decoration: const InputDecoration(labelText: 'Username'),
  ),
  TextField(
  controller: _passwordController,
  decoration: const InputDecoration(labelText: 'Password'),
  obscureText: true,
  ),
  const SizedBox(height: 20),
  if (_error != null)
  Text(_error!, style: const TextStyle(color: Colors.red)),
  ElevatedButton(
  onPressed: _loading ? null : _login,
  child: _loading
  ? const CircularProgressIndicator()
      : const Text('Login'),
  ),
  ],
  ),
  ),
  );
  }
  }