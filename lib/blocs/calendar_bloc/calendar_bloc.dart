// calendar_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<DaySelectedEvent>(_onDaySelected);
    on<FormatChangedEvent>(_onFormatChanged);
    on<PageChangedEvent>(_onPageChanged);
  }

  void _onDaySelected(DaySelectedEvent event, Emitter<CalendarState> emit) {
    emit(CalendarUpdated(
      calendarFormat: state is CalendarUpdated ? (state as CalendarUpdated).calendarFormat : CalendarFormat.week,
      focusedDay: event.focusedDay,
      selectedDay: event.selectedDay,
    ));
  }

  void _onFormatChanged(FormatChangedEvent event, Emitter<CalendarState> emit) {
    emit(CalendarUpdated(
      calendarFormat: event.format,
      focusedDay: state is CalendarUpdated ? (state as CalendarUpdated).focusedDay : DateTime.now(),
      selectedDay: state is CalendarUpdated ? (state as CalendarUpdated).selectedDay : null,
    ));
  }

  void _onPageChanged(PageChangedEvent event, Emitter<CalendarState> emit) {
    emit(CalendarUpdated(
      calendarFormat: state is CalendarUpdated ? (state as CalendarUpdated).calendarFormat : CalendarFormat.week,
      focusedDay: event.focusedDay,
      selectedDay: state is CalendarUpdated ? (state as CalendarUpdated).selectedDay : null,
    ));
  }
}
