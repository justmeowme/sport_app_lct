import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_event.dart';

import '../auth/start_screen.dart';

class CoachHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная (Тренер)'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => StartScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('У тренера тоже все гуд!'),
      ),
    );
  }
}
