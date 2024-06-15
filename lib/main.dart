import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/repositories/auth_repository.dart';
import 'package:sport_app_lct/repositories/course_repository.dart';
import 'package:sport_app_lct/repositories/exercise_repository.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';
import 'package:sport_app_lct/screens/auth/start_screen.dart';
import 'package:sport_app_lct/screens/coach/coach_main_screen.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/course_bloc/course_bloc.dart';
import 'blocs/course_bloc/course_event.dart';
import 'blocs/exercise_bloc/exercise_bloc.dart';
import 'models/user.dart';
import 'screens/client/client_home_screen.dart';
import 'screens/coach/coach_home_screen.dart';
import 'services/auth/auth_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final courseRepository = CourseRepository();
    final userRepository = UserRepository();
    final exerciseRepository = ExerciseRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository(), userRepository: UserRepository()),
        ),
        BlocProvider<CoursesBloc>(
            create: (context) => CoursesBloc( courseRepository: courseRepository, userRepository: userRepository)
        ),
        BlocProvider<ExerciseBloc>(
          create: (context) => ExerciseBloc(exerciseRepository: exerciseRepository),
        )
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
                      return CoachMainScreen();
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
