import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/screens/courses/courses_list.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_extendable.dart';
import 'package:sport_app_lct/widgets/description.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../blocs/course_bloc/course_event.dart';
import '../../blocs/course_bloc/course_state.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/screens/courses/courses_list.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_extendable.dart';
import 'package:sport_app_lct/widgets/description.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../blocs/course_bloc/course_event.dart';
import '../../blocs/course_bloc/course_state.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/header.dart';

class CreateCourse extends StatefulWidget {
  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController = TextEditingController();
  int _difficulty = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoursesBloc, CoursesState>(
      listener: (context, state) {
        if (state is CourseCreationSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CoursesList(),
            ),
          );
        } else if (state is CoursesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 48, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Image.asset("assets/back_button.png", height: 44, width: 44,),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CoursesList(),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Center(
                    child: Header(text: "Шаг 1",),
                  ),
                  Spacer(),
                  SizedBox(width: 44),
                ],
              ),
              SizedBox(height: 24,),
              CustomInput(
                controller: _courseNameController,
                isDescription: true,
                description: "Название курса",
              ),
              SizedBox(height: 16,),
              CustomInputExtendable(
                controller: _courseDescriptionController,
                description: "Описание курса",
                isDescription: true,
              ),
              SizedBox(height: 16),
              Description(text: "Сложность"),
              SizedBox(height: 4,),
              FormWidget(
                isMultiSelect: false,
                isHorizontal: false,
                items: [
                  {'icon': Icons.battery_1_bar, 'text': 'Легкая'},
                  {'icon': Icons.battery_3_bar, 'text': 'Нормальная'},
                  {'icon': Icons.battery_5_bar, 'text': 'Средняя'},
                  {'icon': Icons.battery_full, 'text': 'Сложная'}
                ],
                onItemSelected: (index) {
                  setState(() {
                    _difficulty = index + 1;
                  });
                },
              ),
              Spacer(),
              ButtonPrimary(
                text: "Создать курс",
                onPress: () {
                  final course = Course(
                    id: 0,
                    title: _courseNameController.text,
                    description: _courseDescriptionController.text,
                    difficultyNumeric: _difficulty,
                    difficulty: _difficulty == 1 ? "Легкая" : _difficulty == 2 ? "Нормальная" : _difficulty == 3 ? "Средняя" : "Сложная",
                    trainerId: 0,
                    classes: [],
                  );
                  print("couse from screen");
                  print(jsonEncode(course.toJson()));
                  BlocProvider.of<CoursesBloc>(context).add(CreateCourseEvent(course));
                },
                isFullWidth: true,
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

}
