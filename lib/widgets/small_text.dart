import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  SmallText({required this.text, this.textAlign = TextAlign.center,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF202439),
        fontSize: 18,
        fontFamily: 'GilroyRegular',
      ),
      textAlign: textAlign,
    );
  }
}
