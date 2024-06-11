import 'package:table_calendar/table_calendar.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {
  final CalendarFormat calendarFormat = CalendarFormat.week;
  final DateTime focusedDay = DateTime.now();
  final DateTime? selectedDay = null;
}

class CalendarUpdated extends CalendarState {
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  CalendarUpdated({
    required this.calendarFormat,
    required this.focusedDay,
    this.selectedDay,
  });
}
