import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved: $token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Retrieved token: $token');
    return token;
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('Token removed');
  }
}
