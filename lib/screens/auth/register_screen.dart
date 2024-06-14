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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              print('User authenticated: ${state.user}');
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
              SizedBox(height: 20,),
              Align(
                child: Image.asset("assets/back_button.png", height: 50, width: 50,),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 20,),
              Header(text: "Ты уже на шаг ближе к спорту!", textAlign: TextAlign.left,),
              SizedBox(height: 20,),
              Align(
                child: SmallText(text: 'Email',),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 12,),
              CustomInput(controller: _usernameController),
              SizedBox(height: 20,),
              Align(
                child: SmallText(text: 'Имя',),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 12,),
              CustomInput(controller: _nameController),
              SizedBox(height: 20,),
              Align(
                child: SmallText(text: 'Пароль',),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 12,),
              CustomInputPassword(controller: _passwordController),
              SizedBox(height: 20,),
              ButtonPrimary(
                text: "Регистрация",
                onPress: () {
                  final login = _usernameController.text;
                  final password = _passwordController.text;
                  final name = _nameController.text;

                  if (login.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Вы не ввели логин или пароль')),
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
              SizedBox(height: 6,),
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
              Text(
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
    );
  }
}
