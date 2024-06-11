import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color textColor;
  final int weight;

  SmallText({required this.text, this.textAlign = TextAlign.center, this.textColor = const Color(0xFF202439), this.weight = 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 18,
        fontFamily: 'GilroyRegular',
        fontWeight: weight == 1 ? FontWeight.bold : FontWeight.normal
      ),
      textAlign: textAlign,
    );
  }
}
