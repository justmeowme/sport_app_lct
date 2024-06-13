import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/widgets/description.dart';
import 'package:sport_app_lct/widgets/header.dart';

class CourseWidget extends StatelessWidget {
  final Course course;

  CourseWidget({required this.course,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        children: [
          Header(text: course.title),
          Description(text: course.description)
        ],
      )
    );
  }
}
