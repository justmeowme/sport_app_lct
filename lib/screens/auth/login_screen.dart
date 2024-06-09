import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/screens/client/client_home_screen.dart';
import 'package:sport_app_lct/widgets/combined_text.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_password.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
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
      backgroundColor: Colors.white,
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
            children: [
              SizedBox(height: 20,),

              Align(
                child: Image.asset("assets/back_button.png", height: 50, width: 50,),
                alignment: Alignment.centerLeft,
              ),

              SizedBox(height: 20,),

              Header(text: "Рады видеть тебя снова!", textAlign: TextAlign.left,),

              SizedBox(height: 20,),

              Align(
                child: SmallText(text: 'Email',),
                alignment: Alignment.centerLeft,
              ),

              SizedBox(height: 12,),

              CustomInput(controller: _usernameController),

              SizedBox(height: 20,),

              Align(
                child: SmallText(text: 'Пароль',),
                alignment: Alignment.centerLeft,
              ),

              SizedBox(height: 12,),

              CustomInputPassword(controller: _passwordController),

              SizedBox(height: 64),
              
              ButtonPrimary(
                  text: "Вход",
                  onPress: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignInEvent(
                        login: _usernameController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                isFullWidth: true,
              ),

              SizedBox(height: 12,),

              CombinedText(
                  mainText: "Еще нет аккаунта?",
                  clickableText: "Регистрация",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
              ),

              SizedBox(height: 6,),

              CombinedText(
                mainText: "Войти как",
                clickableText: "тренер",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
