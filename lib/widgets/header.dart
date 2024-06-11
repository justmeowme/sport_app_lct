import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color textColor;

  Header({required this.text, this.textAlign = TextAlign.center, this.textColor = const Color(0xFF202439)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: 32,
          fontFamily: 'RussoOne',
      ),
      textAlign: textAlign,
    );
  }
}

