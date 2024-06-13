import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/class.dart';
import '../services/auth/auth_service.dart';

class ClassRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080';

  Future<List<Class>> getClasses(int courseId) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse('$baseUrl/v1/course/$courseId/classes'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['classes'];
      return body.map((dynamic item) => Class.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<Class> getClassById(int courseId, int classId) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse('$baseUrl/v1/course/$courseId/classes/$classId'), headers: headers);

    if (response.statusCode == 200) {
      return Class.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load class');
    }
  }

  Future<void> createClass(int courseId, Class newClass) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('$baseUrl/v1/course/$courseId/classes'),
      headers: headers,
      body: jsonEncode(newClass.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create class');
    }
  }

  Future<void> updateClass(int courseId, int classId, Class updatedClass) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.put(
      Uri.parse('$baseUrl/v1/course/$courseId/classes/$classId'),
      headers: headers,
      body: jsonEncode(updatedClass.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update class');
    }
  }

  Future<void> deleteClass(int courseId, int classId) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(
      Uri.parse('$baseUrl/v1/course/$courseId/classes/$classId'),
      headers: headers
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete class');
    }
  }
}
