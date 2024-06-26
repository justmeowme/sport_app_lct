import '../../models/course.dart';

abstract class CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<Course> courses;

  CoursesLoaded(this.courses);
}

class CourseCreationSuccess extends CoursesState {}

class CoursesError extends CoursesState {
  final String message;

  CoursesError(this.message);
}

class CourseLoading extends CoursesState {}

class CourseLoaded extends CoursesState {
  final Course course;

  CourseLoaded(this.course);
}
