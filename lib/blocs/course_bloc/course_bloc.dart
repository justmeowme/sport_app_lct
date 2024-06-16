import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/repositories/course_repository.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';

import 'course_event.dart';
import 'course_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository courseRepository;
  final UserRepository userRepository;

  CoursesBloc({required this.courseRepository, required this.userRepository}) : super(CoursesLoading()) {
    on<LoadCourses>(_onLoadCourses);
    on<CreateCourseEvent>(_onCreateCourseEvent);
    on<LoadCourseById>(_onLoadCourseById);
  }

  void _onLoadCourses(LoadCourses event, Emitter<CoursesState> emit) async {
    emit(CoursesLoading());
    try {
      final courses = await courseRepository.getCourses();
      emit(CoursesLoaded(courses));
    } catch (e) {
      emit(CoursesError("Failed to load courses + $e"));
    }
  }

  void _onCreateCourseEvent(CreateCourseEvent event, Emitter<CoursesState> emit) async {
    try {
      final currentUser = await userRepository.getCurrentUser();
      final course = event.course.copyWith(trainerId: currentUser.id);
      await courseRepository.createCourse(course);
      emit(CourseCreationSuccess());
      add(LoadCourses());
    } catch (e) {
      emit(CoursesError("Failed to create course"));
    }
  }

  void _onLoadCourseById(LoadCourseById event, Emitter<CoursesState> emit) async {
    emit(CourseLoading());
    try {
      final course = await courseRepository.getCourseById(event.courseId);
      emit(CourseLoaded(course));
    } catch (e) {
      print("error is");
      print(e);
      emit(CoursesError("Failed to load course by ID + $e"));
    }
  }
}
