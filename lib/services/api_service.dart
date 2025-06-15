import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  static const String apiKey = 'test';

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'X-API-Key': apiKey,
  };

  static Future<Map<String, dynamic>?> login(
      String username, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: _headers,
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<List<dynamic>> fetchLeaderboard([int limit = 10]) async {
    final res = await http.get(
      Uri.parse('$baseUrl/leaderboard?limit=$limit'),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    return [];
  }

  static Future<Map<String, dynamic>?> fetchProfile(String chatId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/profile/$chatId'),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    return null;
  }
}