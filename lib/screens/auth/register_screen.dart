import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/screens/auth/login_screen.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step1.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input_password.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../../widgets/combined_text.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/header.dart';
import '../../widgets/small_text.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20,),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => OnboardingStep1(user: state.user),
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
                Header(text: "Ты уже на шаг ближе к спорту!", textAlign: TextAlign.left,),
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
                  child: SmallText(text: 'Имя',),
                ),
                const SizedBox(height: 12,),
                CustomInput(controller: _nameController),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(text: 'Пароль',),
                ),
                const SizedBox(height: 12,),
                CustomInputPassword(controller: _passwordController),
                const SizedBox(height: 20,),
                ButtonPrimary(
                  text: "Регистрация",
                  onPress: () {
                    final login = _usernameController.text;
                    final password = _passwordController.text;
                    final name = _nameController.text;

                    if (login.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Вы не ввели логин или пароль')),
                      );
                      return;
                    }

                    BlocProvider.of<AuthBloc>(context).add(
                      SignUpEvent(
                        login: login,
                        password: password,
                        name: name,
                      ),
                    );
                  },
                  isFullWidth: true,
                ),
                const SizedBox(height: 6,),
                CombinedText(
                  mainText: "Уже есть аккаунт?",
                  clickableText: "Войти",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12,),
                const Text(
                  "Нажимая на кнопку регистрации, вы соглашаетесь с Правилами Использования и Политикой Конфиденциальности",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'GilroyRegular'
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
