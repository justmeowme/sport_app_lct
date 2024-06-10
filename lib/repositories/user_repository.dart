import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sport_app_lct/services/auth/auth_service.dart';
import '../models/user.dart';

class UserRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1/user';

  Future<void> completeOnboarding(User user) async {
    final token = await AuthService().getToken();

    final url = '$baseUrl/onboarding';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(user.toJson());

    print('Request URL: $url');
    print('Request Headers: $headers');
    print('Request Body: $body');

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to complete onboarding: ${response.statusCode}');
    }
  }

}
