import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/classes_repository.dart';
import 'classes_event.dart';
import 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final ClassesRepository classesRepository;

  ClassesBloc({required this.classesRepository}) : super(ClassesLoading()) {
    on<LoadClasses>(_onLoadClasses);
    on<AddClasses>(_onAddClasses);
    on<UpdateClasses>(_onUpdateClasses);
  }

  Future<void> _onLoadClasses(LoadClasses event, Emitter<ClassesState> emit) async {
    emit(ClassesLoading());
    try {
      final classes = await classesRepository.getClasses(event.courseId);
      emit(ClassesLoaded(classes));
    } catch (e) {
      emit(ClassesError("Failed to load classes: $e"));
    }
  }

  Future<void> _onAddClasses(AddClasses event, Emitter<ClassesState> emit) async {
    try {
      final classes = await classesRepository.addClasses(event.courseId, event.classes);
      emit(ClassAdded(classes));
    } catch (e) {
      emit(ClassesError("Failed to add class: $e"));
    }
  }

  Future<void> _onUpdateClasses(UpdateClasses event, Emitter<ClassesState> emit) async {
    try {
      final updatedClasses = await classesRepository.updateClasses(event.courseId, event.classId, event.classes);
      emit(ClassUpdated(updatedClasses));
    } catch (e) {
      emit(ClassesError("Failed to update class: $e"));
    }
  }
}
