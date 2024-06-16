import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_event.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_state.dart';
import 'package:sport_app_lct/screens/client/client_home_screen.dart';
import 'package:sport_app_lct/models/user.dart';
import 'package:sport_app_lct/widgets/custom_input_extendable.dart';

import '../../widgets/button_primary.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/small_text.dart';

class OnboardingStep4 extends StatefulWidget {
  final User user;

  OnboardingStep4({required this.user});

  @override
  _OnboardingStep4State createState() => _OnboardingStep4State();
}

class _OnboardingStep4State extends State<OnboardingStep4> {
  bool hasHealthConditions = true;

  final TextEditingController _healthConditionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(widget.user));
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
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
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44),
              SmallText(text: "4/4", textColor: Color(0xFFED6929)),
              SizedBox(height: 12),
              Header(text: "Есть ли у тебя", textAlign: TextAlign.left),
              Header(text: "травмы или", textAlign: TextAlign.left),
              Header(text: "противопоказания?", textAlign: TextAlign.left),
              SizedBox(height: 20),
              FormWidget(
                isMultiSelect: false,
                isHorizontal: false,
                items: [
                  {'icon': null, 'text': 'Да'},
                  {'icon': null, 'text': 'Нет'},
                ],
                onItemSelected: (index) {
                  setState(() {
                    hasHealthConditions = index == 0;
                    if (!hasHealthConditions) {
                      _healthConditionController.clear();
                    }
                  });
                },
              ),
              SizedBox(height: 24),
              if (hasHealthConditions)
                CustomInputExtendable(
                  controller: _healthConditionController,
                  hintText: "Введите свои противопоказания и травмы",
                ),
              Spacer(),
              ButtonPrimary(
                text: "Завершить",
                isFullWidth: true,
                onPress: () {
                  final updatedUser = widget.user.copyWith(
                      healthConditions: (hasHealthConditions && _healthConditionController.text.isNotEmpty) ? "Противопоказания и травмы: ${_healthConditionController.text}" : "Нет противопоказаний и травм"
                  );

                  print(jsonEncode(updatedUser));

                  BlocProvider.of<AuthBloc>(context).add(
                    CompleteOnboardingEvent(user: updatedUser),
                  );
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      )
    );
  }
}
