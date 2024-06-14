import 'package:bloc/bloc.dart';
import 'package:sport_app_lct/repositories/course_repository.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';

import 'course_event.dart';
import 'course_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository courseRepository;
  final UserRepository userRepository;

  CoursesBloc(this.courseRepository, this.userRepository) : super(CoursesLoading()) {
    on<LoadCourses>(_onLoadCourses);
    on<CreateCourseEvent>(_onCreateCourseEvent);
  }

  void _onLoadCourses(LoadCourses event, Emitter<CoursesState> emit) async {
    emit(CoursesLoading());
    try {
      final courses = await courseRepository.getCourses();
      emit(CoursesLoaded(courses));
    } catch (e) {
      emit(CoursesError("Failed to load courses + ${e}"));
      print("error is ${e}");
    }
  }

  void _onCreateCourseEvent(CreateCourseEvent event, Emitter<CoursesState> emit) async {
    try {
      final currentUser = await userRepository.getCurrentUser();
      print("USER ID IS ${currentUser.id}");
      final course = event.course.copyWith(trainerId: 5);
      await courseRepository.createCourse(course);
      emit(CourseCreationSuccess());
      add(LoadCourses());
    } catch (e) {
      print("error create is ${e}");
      print("COURSE IS HERE");
      emit(CoursesError("Failed to create course"));

    }
  }
}
