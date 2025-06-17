import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = 'http://localhost:8080';

  static var baseUrl = 'http://localhost:8080' ;


  static Map<String, String> headers(String initData) => {
    'Content-Type': 'application/json',
    'Authorization': 'tma $initData',
    'X-API-Key': apiKey,
  };

  static Future<Map<String, dynamic>?> login(
      String initData, int chatId, String username) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers(initData),
      body: jsonEncode({
        'chat_id': chatId,
        'username': username,
      }),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> fetchProfile(
      String initData, int chatId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/profile/$chatId'),
      headers: headers(initData),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<List<dynamic>> fetchLeaderboard(String initData, [int limit = 10]) async {
    final res = await http.get(
      Uri.parse('$baseUrl/leaderboard?limit=$limit'),
      headers: headers(initData),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    return [];
  }


  static Future<List<dynamic>> fetchReferrals(String initData) async {
    final res = await http.get(
      Uri.parse('$baseUrl/referrals'),
      headers: headers(initData),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    return [];
  }


  static Future<List<dynamic>> fetchDailyTasks(String initData, int chatId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/tasks/daily?chat_id=$chatId'),
      headers: headers(initData),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    return [];
  }

  static Future<bool> completeTask(
      String initData, int chatId, int taskId) async {
    final res = await http.post(
      Uri.parse('$baseUrl/tasks/complete'),
      headers: headers(initData),
      body: jsonEncode({'chat_id': chatId, 'task_id': taskId}),
    );
    return res.statusCode == 200;
  }

  static Future<bool> claimFarming(String initData, int chatId) async {
    final res = await http.post(
      Uri.parse('$baseUrl/farming'),
      headers: headers(initData),
      body: jsonEncode({'chat_id': chatId}),
    );
    return res.statusCode == 200;
  }

  static Future<bool> tap(String initData, int chatId) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/tap'),
      headers: headers(initData),
      body: jsonEncode({'chat_id': chatId}),
    );
    return res.statusCode == 200;
  }
}

