import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_event.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_state.dart';
import 'package:sport_app_lct/models/exercise.dart';
import 'package:sport_app_lct/widgets/exercise_widget.dart';

class ExerciseList extends StatelessWidget {
  final String? muscle;
  final String? difficulty;

  ExerciseList({this.muscle, this.difficulty});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExerciseBloc>(context).add(
      FilterExercisesEvent(
        muscle: muscle,
        difficulty: difficulty,
      ),
    );

    return BlocBuilder<ExerciseBloc, ExerciseState>(
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
                      updatedAt: exercise.updatedAt,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              );
            },
          );
        } else if (state is ExerciseErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Упражнений не найдено'));
        }
      },
    );
  }
}
