import 'dart:convert';
import 'package:http/http.dart' as http;
import '../theme/themecontroller.dart';

class ApiService {
  static const baseUrl = 'http://127.0.0.1:8000'; // FastAPI backend

  // Health check
  static Future<Map<String, dynamic>> healthCheck() async {
    final res = await http.get(Uri.parse('$baseUrl/health'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to connect to backend');
    }
  }

  // Example: fetch downloads (you can add more endpoints here)
  static Future<List<dynamic>> getDownloads() async {
    final res = await http.get(Uri.parse('$baseUrl/downloads')); // replace with real route
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to fetch downloads');
    }
  }
}
