import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/models/exercise.dart';
import 'package:sport_app_lct/repositories/exercise_repository.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_event.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseBloc({required this.exerciseRepository}) : super(ExerciseInitialState()) {
    on<LoadExercisesEvent>(_onLoadExercises);
  }

  void _onLoadExercises(LoadExercisesEvent event, Emitter<ExerciseState> emit) async {
    emit(ExerciseLoadingState());
    try {
      final exercises = await exerciseRepository.getExercises();
      print("here exercises");
      print(exercises[0]);
      emit(ExerciseLoadedState(exercises: exercises));
    } catch (e) {
      print("exersise error $e");
      emit(ExerciseErrorState(message: e.toString()));
    }
  }
}
