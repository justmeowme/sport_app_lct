import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/exercise.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color color;

  Tag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'GilroyMedium',
            ),
          ),
        ),
      )
    );
  }
}
