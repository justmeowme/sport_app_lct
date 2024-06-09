import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  Header({
    required this.text,
    this.textAlign = TextAlign.center,  // Значение по умолчанию
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF202439),
        fontSize: 32,
        fontFamily: 'RussoOne',
      ),
      textAlign: textAlign,
    );
  }
}
