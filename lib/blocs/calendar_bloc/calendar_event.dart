import 'package:table_calendar/table_calendar.dart';

abstract class CalendarEvent {}

class DaySelectedEvent extends CalendarEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  DaySelectedEvent({required this.selectedDay, required this.focusedDay});
}

class FormatChangedEvent extends CalendarEvent {
  final CalendarFormat format;

  FormatChangedEvent({required this.format});
}

class PageChangedEvent extends CalendarEvent {
  final DateTime focusedDay;

  PageChangedEvent({required this.focusedDay});
}
