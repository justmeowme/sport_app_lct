import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/screens/client/client_home_screen.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ClientHomeScreen(),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Логин'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    SignInEvent(
                      login: _usernameController.text,
                      password: _passwordController.text,
                    ),
                  );
                },
                child: Text('Логин'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<AuthBloc>(context),
                        child: RegisterScreen(),
                      ),
                    ),
                  );
                },
                child: Text('Регистрация'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
