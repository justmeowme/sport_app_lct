import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_event.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_state.dart';
import 'package:sport_app_lct/screens/client/client_home_screen.dart';
import 'package:sport_app_lct/models/user.dart';

class OnboardingStep4 extends StatefulWidget {
  final User user;

  OnboardingStep4({required this.user});

  @override
  _OnboardingStep4State createState() => _OnboardingStep4State();
}

class _OnboardingStep4State extends State<OnboardingStep4> {
  final _formKey = GlobalKey<FormState>();
  String? _healthConditions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Step 4'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Health Conditions'),
                  onSaved: (value) {
                    _healthConditions = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your health conditions';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final updatedUser = widget.user.copyWith(
                        healthConditions: _healthConditions,
                      );

                      BlocProvider.of<AuthBloc>(context).add(
                        CompleteOnboardingEvent(user: updatedUser),
                      );
                    }
                  },
                  child: Text('Complete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
