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
  const CreateCourse({super.key});

  @override
  CreateCourseState createState() => CreateCourseState();
}

class CreateCourseState extends State<CreateCourse> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController = TextEditingController();
  int _difficulty = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoursesBloc, CoursesState>(
      listener: (context, state) {
        if (state is CourseCreationSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CoursesList(),
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
          padding: const EdgeInsets.only(top: 48, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Image.asset("assets/back_button.png", height: 44, width: 44,),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: Header(text: "Шаг 1",),
                  ),
                  const Spacer(),
                  const SizedBox(width: 44),
                ],
              ),
              const SizedBox(height: 24,),
              CustomInput(
                controller: _courseNameController,
                isDescription: true,
                description: "Название курса",
              ),
              const SizedBox(height: 16,),
              CustomInputExtendable(
                controller: _courseDescriptionController,
                description: "Описание курса",
                isDescription: true,
              ),
              const SizedBox(height: 16),
              Description(text: "Сложность"),
              const SizedBox(height: 4,),
              FormWidget(
                isMultiSelect: false,
                isHorizontal: false,
                items: const [
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
              const Spacer(),
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
                  BlocProvider.of<CoursesBloc>(context).add(CreateCourseEvent(course));
                },
                isFullWidth: true,
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
