import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/repositories/exercise_repository.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_event.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseBloc({required this.exerciseRepository}) : super(ExerciseInitialState()) {
    on<LoadExercisesEvent>(_onLoadExercises);
    on<FilterExercisesEvent>(_onFilterExercises);
  }

  void _onLoadExercises(LoadExercisesEvent event, Emitter<ExerciseState> emit) async {
    emit(ExerciseLoadingState());
    try {
      final exercises = await exerciseRepository.getExercises();
      emit(ExerciseLoadedState(exercises: exercises));
    } catch (e) {
      emit(ExerciseErrorState(message: e.toString()));
    }
  }

  void _onFilterExercises(FilterExercisesEvent event, Emitter<ExerciseState> emit) async {
    emit(ExerciseLoadingState());
    try {
      final exercises = await exerciseRepository.getExercisesFiltered(
        muscle: event.muscle,
        difficulty: event.difficulty,
      );
      emit(ExerciseLoadedState(exercises: exercises));
    } catch (e) {
      emit(ExerciseErrorState(message: e.toString()));
    }
  }


}
