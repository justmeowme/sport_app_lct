import '../../models/exercise.dart';

abstract class ExerciseState {}

class ExerciseInitialState extends ExerciseState {}

class ExerciseLoadingState extends ExerciseState {}

class ExerciseLoadedState extends ExerciseState {
  final List<Exercise> exercises;
  ExerciseLoadedState({required this.exercises});
}

class ExerciseErrorState extends ExerciseState {
  final String message;
  ExerciseErrorState({required this.message});
}
