import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080';


  static Map<String, String> headers(String initData) => {
    'Content-Type': 'application/json',
    'Authorization': 'tma $initData',
  };

  static Future<Map<String, dynamic>?> fetchProfile(String initData) async {
    final res = await http.get(
      Uri.parse('$baseUrl/profile'),
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


  static Future<List<dynamic>> fetchDailyTasks(String initData) async {
    final res = await http.get(
      Uri.parse('$baseUrl/tasks/daily'),
      headers: headers(initData),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    }
    return [];
  }
}
