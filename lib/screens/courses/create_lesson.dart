import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/models/exercise.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/exercise_widget.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

import '../../blocs/exercise_bloc/exercise_bloc.dart';
import '../../blocs/exercise_bloc/exercise_event.dart';
import '../../blocs/exercise_bloc/exercise_state.dart';
import '../../repositories/exercise_repository.dart';
import '../../widgets/custom_input_age.dart';

class CreateLesson extends StatelessWidget {
  final Course course;
  final TextEditingController _durationController = TextEditingController();

  CreateLesson({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 20, right: 20, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/back_button.png", height: 32),
                        ),
                      ),
                      Spacer(),
                      Header(text: "Упражнения", textAlign: TextAlign.left,),
                      SizedBox(width: 32,),
                      Spacer(),
                    ],
                  ),

                  SizedBox(height: 16,),

                  CustomInputAge(
                    controller: _durationController,
                    isDescription: true,
                    description: "Длительность упражнения (в секундах)",
                  ),

                  SizedBox(height: 16,),

                  SmallText(text: "Список упражнений"),


                  BlocProvider(
                    create: (context) => ExerciseBloc(exerciseRepository: ExerciseRepository())..add(LoadExercisesEvent()),
                    child: Container(
                      height: 500,
                      child: BlocBuilder<ExerciseBloc, ExerciseState>(
                        builder: (context, state) {
                          if (state is ExerciseLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is ExerciseLoadedState) {
                            return ListView.builder(
                              itemCount: state.exercises.length,
                              itemBuilder: (context, index) {
                                final exercise = state.exercises[index];
                                return Column(
                                  children: [
                                    ExerciseWidget(
                                      selected: false,
                                      exercise: Exercise(
                                          id: exercise.id,
                                          additionalMuscle: exercise.additionalMuscle,
                                          createdAt: exercise.createdAt,
                                          difficulty: exercise.difficulty,
                                          equipment: exercise.equipment,
                                          muscle: exercise.muscle,
                                          name: exercise.name,
                                          originalUri: exercise.originalUri,
                                          photos: exercise.photos,
                                          type: exercise.type,
                                          updatedAt: exercise.updatedAt
                                      )
                                    ),
                                    SizedBox(height: 8,)
                                  ],
                                );
                              },
                            );
                          } else if (state is ExerciseErrorState) {
                            return Center(child: Text('Error: ${state.message}'));
                          } else {
                            return Center(child: Text('No exercises found'));
                          }
                        },
                      ),
                    ),
                  ),

                  Spacer(),
                  ButtonPrimary(
                    text: "Добавить",
                    onPress: (){

                    },
                    isFullWidth: true,
                  ),
                ],
              ),
            )
        )
    );
  }
}
