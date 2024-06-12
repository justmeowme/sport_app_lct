import '../../models/shedule.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Shedule> schedules;

  ScheduleLoaded(this.schedules);
}

class ScheduleError extends ScheduleState {
  final String error;

  ScheduleError(this.error);
}
