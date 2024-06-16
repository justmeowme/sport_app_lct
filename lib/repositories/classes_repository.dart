import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/classes.dart';
import '../services/auth/auth_service.dart';

class ClassesRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1';

  Future<List<Classes>> getClasses(int courseId) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('$baseUrl/course/$courseId/classes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      print(responseBody);
      print("CLASSES HERE");

      if (responseBody.containsKey('classes') && responseBody['classes'] != null) {
        List<dynamic> body = responseBody['classes'];
        return body.map((dynamic item) => Classes.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<Classes> addClasses(int courseId, Classes classes) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(classes.toJson());

    final response = await http.post(
      Uri.parse('$baseUrl/course/$courseId/classes'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      return Classes.fromJson(jsonDecode(response.body)['class']);
    } else {
      throw Exception('Failed to add class');
    }
  }

  Future<Classes> updateClasses(int courseId, int classId, Classes classes) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(classes.toJson());

    final response = await http.put(
      Uri.parse('$baseUrl/course/$courseId/classes/$classId'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return Classes.fromJson(jsonDecode(response.body)['class']);
    } else {
      throw Exception('Failed to update class');
    }
  }
}
