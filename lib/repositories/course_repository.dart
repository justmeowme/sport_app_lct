import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import '../services/auth/auth_service.dart';

class CourseRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1';

  Future<List<Course>> getCourses() async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse('$baseUrl/course'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['courses'];
      return body.map((dynamic item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Course> getCourseById(int courseId) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse('$baseUrl/course/$courseId'), headers: headers);

    print("RESPONSE BODY COURSE");
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course');
    }
  }

  Future<Map<String, dynamic>> createCourse(Course course) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('$baseUrl/course'),
      headers: headers,
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create course. ${response.body}');
    }
  }

  Future<void> updateCourse(int courseId, Course course) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
      Uri.parse('$baseUrl/v1/course/$courseId'),
      headers: headers,
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update course');
    }
  }
}
