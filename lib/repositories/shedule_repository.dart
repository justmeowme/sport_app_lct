import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shedule.dart';
import '../services/auth/auth_service.dart';

class ScheduleRepository {
  final String baseUrl = 'http://sport-plus.sorewa.ru:8080/v1/calendar';

  Future<List<Shedule>> getSchedules() async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(baseUrl + '/local'), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Shedule> schedules = data.map((json) => Shedule.fromJson(json)).toList();
      return schedules;
    } else {
      throw Exception('Failed to load schedules Error: ${response.toString()}');
    }
  }
}
