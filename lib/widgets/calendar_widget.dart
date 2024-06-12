// calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar_bloc/calendar_bloc.dart';
import '../../blocs/calendar_bloc/calendar_state.dart';
import '../../blocs/calendar_bloc/calendar_event.dart';

class CalendarWidget extends StatelessWidget {
  late final DateTime kToday;
  late final DateTime kFirstDay;
  late final DateTime kLastDay;

  CalendarWidget({Key? key}) : super(key: key) {
    kToday = DateTime.now();
    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
  }

  // Function to create text style
  TextStyle _createTextStyle(Color color, String fontFamily) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
    );
  }

  @override
  Widget build(BuildContext context) {
    final commonTextStyle = _createTextStyle(Colors.white, 'GilroyMedium');
    final outsideTextStyle = _createTextStyle(Color(0x50FFFFFF), 'GilroyMedium');
    final todayTextStyle = _createTextStyle(Color(0xFF202439), 'GilroyMedium');
    final selectedTextStyle = _createTextStyle(Colors.white, 'GilroyMedium').copyWith(fontSize: 16);

    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        final calendarFormat = state is CalendarUpdated ? state.calendarFormat : CalendarFormat.week;

        return TableCalendar(
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: _createTextStyle(Colors.white, 'RussoOne'),
            weekendStyle: _createTextStyle(Colors.white, 'RussoOne'),
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: commonTextStyle,
            weekendTextStyle: commonTextStyle,
            outsideTextStyle: outsideTextStyle,
            todayTextStyle: todayTextStyle,
            todayDecoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Color(0x50FFFFFF),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: selectedTextStyle,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          locale: 'ru_RU',
          headerVisible: false,
          focusedDay: state is CalendarUpdated ? state.focusedDay : DateTime.now(),
          calendarFormat: calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(state is CalendarUpdated ? state.selectedDay : null, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            context.read<CalendarBloc>().add(DaySelectedEvent(selectedDay: selectedDay, focusedDay: focusedDay));
          },
          onFormatChanged: (format) {
            context.read<CalendarBloc>().add(FormatChangedEvent(format: format));
          },
          onPageChanged: (focusedDay) {
            context.read<CalendarBloc>().add(PageChangedEvent(focusedDay: focusedDay));
          },
        );
      },
    );
  }
}
