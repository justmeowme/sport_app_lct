import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CombinedText extends StatelessWidget {
  final String mainText;
  final String clickableText;
  final VoidCallback onTap;

  CombinedText({
    required this.mainText,
    required this.clickableText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$mainText ",
            style: const TextStyle(
              color: Color(0xFF202439),
              fontSize: 16,
              fontFamily: 'GilroyRegular',
            ),
          ),
          TextSpan(
            text: clickableText,
            style: const TextStyle(
              color: Color(0xFFED6929),
              fontSize: 16,
              fontFamily: 'GilroyMedium',
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),

        ],
      ),
    );
  }
}
