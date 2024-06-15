import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/widgets/button_secondary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../coach/coach_main_screen.dart';

class CoachLoginScreen extends StatelessWidget {

  final TextEditingController _codeController = TextEditingController();

  CoachLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFED6929),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const CoachMainScreen(),
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
            const SizedBox(height: 120,),

            Header(text: "Введите код", textColor: Colors.white),

            const SizedBox(height: 12,),

            SmallText(text: "Код можно получить от менеджера или в спортзале, где вы работаете", textColor: Colors.white,),

            const SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: CustomInput(controller: _codeController),
            ),

            const Spacer(),

            ButtonSecondary(
              text: "Войти",
              onPress: () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignInEvent(
                    login: "coach_acc0",
                    password: "12345",
                  ),
                );
              },
              isFullWidth: true,
            ),

            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }
}
