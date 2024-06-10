import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../services/auth/auth_service.dart';

class AuthRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1/auth';

  Future<User> signIn(String login, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/signin?login=$login&password=$password'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await AuthService().saveToken(token);
      print('Sign-in token saved: $token');
      return User.fromJson(data['user']);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<User> signUp(String login, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': login, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await AuthService().saveToken(token);
      print('Sign-up token saved: $token');
      return User.fromJson(data['user']);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<User> getUserFromToken(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['claims']);
    } else {
      throw Exception('Failed to get user from token');
    }
  }

}
