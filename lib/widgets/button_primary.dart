import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool isFullWidth;

  ButtonPrimary({required this.text, required this.onPress, this.isFullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFED6929),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
