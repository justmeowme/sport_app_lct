import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/coach_login_screen.dart';
import '../screens/client/client_home_screen.dart';
import '../screens/coach/coach_home_screen.dart';
import '../screens/common/settings_screen.dart';
import '../screens/common/terms_of_use_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String coachLogin = '/coach-login';
  static const String onboarding = '/onboarding';
  static const String clientHome = '/client-home';
  static const String coachHome = '/coach-home';
  static const String settings = '/settings';
  static const String terms = '/terms';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    coachLogin: (context) => CoachLoginScreen(),
    clientHome: (context) => ClientHomeScreen(),
    coachHome: (context) => CoachHomeScreen(),
    settings: (context) => SettingsScreen(),
    terms: (context) => TermsOfUseScreen(),
  };
}
