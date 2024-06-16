import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/classes_bloc/classes_bloc.dart';
import 'package:sport_app_lct/blocs/classes_bloc/classes_state.dart';
import 'package:sport_app_lct/models/classes.dart';
import 'package:sport_app_lct/screens/courses/create_lesson.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/header.dart';

import '../../blocs/classes_bloc/classes_event.dart';
import '../../repositories/classes_repository.dart';

class EditCourse extends StatelessWidget {
  final int courseId;

  const EditCourse({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocProvider(
            create: (context) => ClassesBloc(classesRepository: ClassesRepository())..add(LoadClasses(courseId)),
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
                      Header(text: "Занятия", textAlign: TextAlign.left,),
                      const SizedBox(width: 32,),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  BlocBuilder<ClassesBloc, ClassesState>(
                    builder: (context, state) {
                      if (state is ClassesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ClassesLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.classes.length,
                            itemBuilder: (context, index) {
                              print(state.classes);
                              print("HERE ARE LESSONS");
                              final lesson = state.classes[index];
                              return ListTile(
                                title: Text(lesson.title),
                                onTap: () {
                                  // Add onTap action if needed
                                },
                              );
                            },
                          ),
                        );
                      } else if (state is ClassesError) {
                        return Center(child: Text(state.message));
                      }
                      return Container();
                    },
                  ),
                  ButtonPrimary(
                    text: "Добавить урок",
                    onPress: () {
                      final newLesson = Classes(
                        exercises: [],
                        courseId: courseId,
                        title: "EMPTY LESSON",
                      );

                      BlocProvider.of<ClassesBloc>(context).add(AddClasses(courseId, newLesson));

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateLesson(courseId: courseId),
                        ),
                      );
                    },
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
