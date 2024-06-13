import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isDescription;
  final String description;

  CustomInput({
    required this.controller,
    this.isDescription = false,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDescription)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(text: description),
              SizedBox(height: 4,),
            ],
          ),
        Container(
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
        ),
      ],
    );
  }
}
