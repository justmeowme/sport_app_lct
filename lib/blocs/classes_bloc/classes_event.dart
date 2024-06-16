import '../../models/classes.dart';

abstract class ClassesEvent {}

class LoadClasses extends ClassesEvent {
  final int courseId;
  LoadClasses(this.courseId);
}

class AddClasses extends ClassesEvent {
  final int courseId;
  final Classes classes;
  AddClasses(this.courseId, this.classes);
}

class UpdateClasses extends ClassesEvent {
  final int courseId;
  final int classId;
  final Classes classes;
  UpdateClasses(this.courseId, this.classId, this.classes);
}
