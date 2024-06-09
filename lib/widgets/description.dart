import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String text;

  Description({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF202439),
        fontSize: 20,
        fontFamily: 'GilroyRegular',
      ),
      textAlign: TextAlign.center,
    );
  }
}
