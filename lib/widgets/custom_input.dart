import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;

  CustomInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 1,
            blurRadius: 15,
          ),
        ],
        border: Border.all(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Color(0xFF202439),
          fontSize: 20,
          fontFamily: 'GilroyRegular',
        ),
      ),
    );
  }
}
