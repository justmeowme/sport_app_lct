import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step3.dart';
import 'package:sport_app_lct/models/user.dart';

class OnboardingStep2 extends StatefulWidget {
  final User user;

  OnboardingStep2({required this.user});

  @override
  _OnboardingStep2State createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends State<OnboardingStep2> {
  final _formKey = GlobalKey<FormState>();
  String? _goals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Step 2'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Goals'),
                onSaved: (value) {
                  _goals = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your goals';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OnboardingStep3(
                          user: widget.user.copyWith(
                            goals: _goals,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
