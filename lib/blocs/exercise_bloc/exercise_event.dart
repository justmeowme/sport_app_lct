abstract class ExerciseEvent {}

class LoadExercisesEvent extends ExerciseEvent {}

class FilterExercisesEvent extends ExerciseEvent {
  final String? muscle;
  final String? difficulty;

  FilterExercisesEvent({this.muscle, this.difficulty});
}
