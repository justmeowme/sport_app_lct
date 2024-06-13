import 'package:bloc/bloc.dart';
import 'package:sport_app_lct/repositories/course_repository.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';
import 'package:sport_app_lct/models/course.dart';

abstract class CoursesEvent {}

class LoadCourses extends CoursesEvent {}

class CreateCourseEvent extends CoursesEvent {
  final Course course;

  CreateCourseEvent(this.course);
}
