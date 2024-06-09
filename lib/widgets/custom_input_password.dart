import 'package:flutter/material.dart';

class CustomInputPassword extends StatefulWidget {
  final TextEditingController controller;

  CustomInputPassword({required this.controller});

  @override
  _CustomInputPasswordState createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
  bool _isObscured = true;

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
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
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
