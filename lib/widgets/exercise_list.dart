import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/exercise.dart';
import 'package:sport_app_lct/widgets/exercise_widget.dart';

class ExerciseList extends StatefulWidget {
  final List<Exercise> exercises;
  final String? muscle;
  final String? difficulty;
  final Function(Exercise) onExerciseSelected;

  ExerciseList({
    required this.exercises,
    this.muscle,
    this.difficulty,
    required this.onExerciseSelected,
  });

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  Exercise? _selectedExercise;

  @override
  Widget build(BuildContext context) {
    List<Exercise> filteredExercises = widget.exercises.where((exercise) {
      bool matchesMuscle = widget.muscle == null || exercise.muscle == widget.muscle;
      bool matchesDifficulty = widget.difficulty == null || exercise.difficulty == widget.difficulty;
      return matchesMuscle && matchesDifficulty;
    }).toList();

    if (filteredExercises.isEmpty) {
      return Center(child: Text('Упражнений не найдено'));
    }

    return ListView.builder(
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        final exercise = filteredExercises[index];
        bool isSelected = _selectedExercise == exercise;

        return Column(
          children: [
            ExerciseWidget(
                selected: isSelected,
                exercise: exercise,
                onSelected: () {
                  setState(() {
                    if (isSelected) {
                      _selectedExercise = null; // Unselect if already selected
                    } else {
                      _selectedExercise = exercise; // Select new exercise
                    }
                  });
                  widget.onExerciseSelected(exercise);
                }
            ),
            SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
