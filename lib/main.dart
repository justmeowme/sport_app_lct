import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/repositories/auth_repository.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';
import 'package:sport_app_lct/screens/auth/start_screen.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'models/user.dart';
import 'screens/client/client_home_screen.dart';
import 'screens/coach/coach_home_screen.dart';
import 'services/auth/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository(), userRepository: UserRepository()),
        ),
      ],
      child: MaterialApp(
        home: FutureBuilder<String?>(
          future: AuthService().getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              return FutureBuilder<User>(
                future: AuthRepository().getUserFromToken(snapshot.data!),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasData && userSnapshot.data != null) {
                    if (userSnapshot.data!.role == 0) {
                      return ClientHomeScreen();
                    } else if (userSnapshot.data!.role == 1) {
                      return CoachHomeScreen();
                    } else {
                      return StartScreen();
                    }
                  } else {
                    return StartScreen();
                  }
                },
              );
            } else {
              return StartScreen();
            }
          },
        ),
      ),
    );
  }
}
