import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'platform_host.dart';

class ApiService {
  // Use the right host based on the current platform.
  static String get serverHost => getServerHost();

  static const String _tokenKey = 'auth_token';

  static Map<String, String> get _jsonHeaders => {
        'Content-Type': 'application/json',
      };

  static Uri _url(String path) => Uri.parse('$serverHost$path');

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<Map<String, String>> _authHeaders() async {
    final token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing. Please login again.');
    }
    return {
      ..._jsonHeaders,
      'Authorization': token,
    };
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final response = await http.post(
      _url('/api/auth/register'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );
    return _parseResponse(response);
  }

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      _url('/api/auth/login'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = _parseResponse(response);
    if (data.containsKey('token')) {
      final token = data['token'] as String;
      await setToken(token);
      return token;
    }

    throw Exception('Login failed: no token returned');
  }

  static Future<Map<String, dynamic>> sendAlert({
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.post(
      _url('/api/alerts/send'),
      headers: await _authHeaders(),
      body: jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
      }),
    );
    return _parseResponse(response);
  }

  static Future<Map<String, dynamic>> addContact({
    required String name,
    required String phone,
  }) async {
    final response = await http.post(
      _url('/api/contacts/add'),
      headers: await _authHeaders(),
      body: jsonEncode({
        'name': name,
        'phone': phone,
      }),
    );
    return _parseResponse(response);
  }

  static Future<List<dynamic>> getContacts() async {
    final response = await http.get(
      _url('/api/contacts/'),
      headers: await _authHeaders(),
    );
    return _parseListResponse(response);
  }

  static Future<Map<String, dynamic>> getUser() async {
    final response = await http.get(
      _url('/api/auth/me'),
      headers: await _authHeaders(),
    );
    return _parseResponse(response);
  }

  static Future<void> logout() async {
    await clearToken();
  }

  static Map<String, dynamic> _parseResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body is Map<String, dynamic> ? body : {'data': body};
    }
    final message = body is Map && body['msg'] != null
        ? body['msg']
        : response.reasonPhrase ?? 'Unknown error';
    throw Exception('API Error: $message');
  }

  static List<dynamic> _parseListResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body is List ? body : [body];
    }
    final message = body is Map && body['msg'] != null
        ? body['msg']
        : response.reasonPhrase ?? 'Unknown error';
    throw Exception('API Error: $message');
  }
}
