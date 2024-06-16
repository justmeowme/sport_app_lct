import 'package:sport_app_lct/models/course.dart';

abstract class CoursesEvent {}

class LoadCourses extends CoursesEvent {}

class CreateCourseEvent extends CoursesEvent {
  final Course course;

  CreateCourseEvent(this.course);
}
