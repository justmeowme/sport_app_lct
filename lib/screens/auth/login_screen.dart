import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/screens/auth/coach_login_screen.dart';
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

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 16),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClientHomeScreen(),
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
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/back_button.png", height: 32),
                  ),
                ),

                const SizedBox(height: 20,),

                Header(text: "Рады видеть тебя снова!", textAlign: TextAlign.left,),

                const SizedBox(height: 20,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(text: 'Email',),
                ),

                const SizedBox(height: 12,),

                CustomInput(controller: _usernameController),

                const SizedBox(height: 20,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(text: 'Пароль',),
                ),

                const SizedBox(height: 12,),

                CustomInputPassword(controller: _passwordController),

                const SizedBox(height: 64),

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

                const SizedBox(height: 12,),

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

                const SizedBox(height: 6,),

                CombinedText(
                  mainText: "Войти как",
                  clickableText: "тренер",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CoachLoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
