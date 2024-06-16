import 'package:sport_app_lct/models/course.dart';

abstract class CoursesEvent {}

class LoadCourses extends CoursesEvent {}

class LoadCourseById extends CoursesEvent {
  final int courseId;

  LoadCourseById(this.courseId);
}

class CreateCourseEvent extends CoursesEvent {
  final Course course;

  CreateCourseEvent(this.course);
}
