import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step4.dart';
import 'package:sport_app_lct/models/user.dart';

class OnboardingStep3 extends StatefulWidget {
  final User user;

  OnboardingStep3({required this.user});

  @override
  _OnboardingStep3State createState() => _OnboardingStep3State();
}

class _OnboardingStep3State extends State<OnboardingStep3> {
  final _formKey = GlobalKey<FormState>();
  String? _experience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Step 3'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Experience'),
                onSaved: (value) {
                  _experience = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience';
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
                        builder: (context) => OnboardingStep4(
                          user: widget.user.copyWith(
                            experience: _experience,
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
