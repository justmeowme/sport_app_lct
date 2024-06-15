import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sport_app_lct/services/auth/auth_service.dart';
import '../models/user.dart';
import 'dart:io';

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

  Future<User> getUserById(int id) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      headers: headers,
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['claims']);
    } else {
      throw Exception('Failed to get user from id');
    }
  }

  Future<User> getCurrentUser() async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      headers: headers,
      Uri.parse('$baseUrl'),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Failed to get current user');
    }
  }
  Future<String> uploadUserIcon(File image) async {
    final token = await AuthService().getToken();
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload/icon'),
    );
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('icon', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      return data['url'];
    } else {
      throw Exception('Failed to upload user icon');
    }
  }

}
