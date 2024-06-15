import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise.dart';
import '../services/auth/auth_service.dart';

class ExerciseRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1/exercise';

  Future<List<Exercise>> getExercises() async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    print("RESPONSE IS $response");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['exercises'];
      final List<Exercise> exercises = data.map((json) =>
          Exercise.fromJson(json)).toList();
      return exercises;
    } else {
      throw Exception(
          'Failed to load exercises. Error: ${response.toString()}');
    }
  }

  Future<List<Exercise>> getExercisesFiltered(
      {String? muscle, String? difficulty, String? additionalMuscle}) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final queryParameters = {
      if (muscle != null) 'muscle': muscle,
      if (difficulty != null) 'difficulty': difficulty,
      if (additionalMuscle != null) 'additional_muscle': additionalMuscle,
    };

    final uri = Uri.parse("$baseUrl/filter").replace(
        queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);

    print("RESPONSE FOR EXERCISE");
    print(response.body.toString());

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['exercises'];
      final List<Exercise> exercises = data.map((json) =>
          Exercise.fromJson(json)).toList();
      return exercises;
    } else {
      throw Exception(
          'Failed to load exercises. Error: ${response.toString()}');
    }
  }
}
