import '../../models/classes.dart';

abstract class ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesLoaded extends ClassesState {
  final List<Classes> classes;
  ClassesLoaded(this.classes);
}

class ClassesError extends ClassesState {
  final String message;
  ClassesError(this.message);
}

class ClassAdded extends ClassesState {
  final Classes classes;
  ClassAdded(this.classes);
}

class ClassUpdated extends ClassesState {
  final Classes classes;
  ClassUpdated(this.classes);
}
