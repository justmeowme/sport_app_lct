import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_state.dart';
import 'package:sport_app_lct/screens/courses/add_exercise.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:sport_app_lct/widgets/exercise_list.dart';

import '../../blocs/classes_bloc/classes_bloc.dart';
import '../../blocs/classes_bloc/classes_event.dart';
import '../../models/classes.dart';
import '../../models/course.dart';

class CreateLesson extends StatelessWidget {
  final int courseId;

  CreateLesson({super.key, required this.courseId});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/back_button.png", height: 32),
                  ),
                  const Spacer(),
                  Header(text: "Создание урока", textAlign: TextAlign.left,),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 32,),
              CustomInput(
                controller: _controller,
                isDescription: true,
                description: "Название урока",
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SmallText(text: "Упражнения"),
                  Spacer(),
                  GestureDetector(
                    child: Icon(Icons.add, color: Color(0xFFED6929),),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddExercise(courseId: courseId),
                        ),
                      );
                    },
                  )
                ],
              ),

              Expanded(
                child: BlocBuilder<ExerciseBloc, ExerciseState>(
                    builder: (context, state) {
                      if (state is ExerciseLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ExerciseLoadedState) {
                        return ExerciseList(
                          exercises: state.exercises ?? [],
                          muscle:  null,
                          difficulty: null, onExerciseSelected: (Exercise ) {  },
                        );
                      } else if (state is ExerciseErrorState) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return Center(child: Text('Упражнений не найдено'));
                      }
                    }
                ),
              ),

              Spacer(),
              ButtonPrimary(
                text: "Сохранить урок",
                onPress: () {

                  // Classes lastLesson = course.classes.last;
                  //
                  // Classes updatedLesson = lastLesson.copyWith(title: _controller.text);
                  //
                  // BlocProvider.of<ClassesBloc>(context).add(UpdateClasses(courseId, lastLesson.id!, updatedLesson));
                  // Navigator.pop(context);
                },
                isFullWidth: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
