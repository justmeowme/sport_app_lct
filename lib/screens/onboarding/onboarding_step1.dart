import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/onboarding/onboarding_step2.dart';
import 'package:sport_app_lct/models/user.dart';

class OnboardingStep1 extends StatefulWidget {
  final User user;

  OnboardingStep1({required this.user});

  @override
  _OnboardingStep1State createState() => _OnboardingStep1State();
}

class _OnboardingStep1State extends State<OnboardingStep1> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  int? _height;
  int? _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Step 1'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _height = int.tryParse(value ?? '');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _weight = int.tryParse(value ?? '');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
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
                        builder: (context) => OnboardingStep2(
                          user: widget.user.copyWith(
                            gender: _gender,
                            height: _height,
                            weight: _weight,
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
