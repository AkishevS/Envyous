// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const String baseUrl = 'https://your-backend.com/api';
//
//   static Future<double> fetchBalance(String chatId) async {
//     final response = await http.get(Uri.parse('\$baseUrl/user/\$chatId'));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return (data['balance'] as num).toDouble();
//     }
//     return 0.0;
//   }
//
//   static Future<void> collectReward(String chatId, String taskId) async {
//     await http.post(
//       Uri.parse('\$baseUrl/tasks/collect'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'chat_id': chatId, 'task_id': taskId}),
//     );
//   }
//
//   static Future<void> registerUser(String chatId, String username) async {
//     await http.post(
//       Uri.parse('\$baseUrl/user'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'chat_id': chatId, 'username': username}),
//     );
//   }
// }
