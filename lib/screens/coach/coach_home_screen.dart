import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar_bloc/calendar_bloc.dart';
import '../../blocs/calendar_bloc/calendar_state.dart';
import '../../blocs/calendar_bloc/calendar_event.dart';

class CoachHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    // Function to create text style
    TextStyle _createTextStyle(Color color, String fontFamily) {
      return TextStyle(
        color: color,
        fontFamily: fontFamily,
      );
    }

    final commonTextStyle = _createTextStyle(Colors.white, 'GilroyMedium');
    final outsideTextStyle = _createTextStyle(Color(0x50FFFFFF), 'GilroyMedium');
    final todayTextStyle = _createTextStyle(Color(0xFF202439), 'GilroyMedium');
    final selectedTextStyle = _createTextStyle(Colors.white, 'GilroyMedium').copyWith(fontSize: 16);

    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFF202439),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            final calendarFormat = state is CalendarUpdated ? state.calendarFormat : CalendarFormat.week;
            return Column(
              children: [
                SizedBox(height: 56,),

                Header(text: DateFormat("yMMM", 'ru').format(kToday).toString(), textColor: Colors.white),

                SizedBox(height: 12,),

                TableCalendar(
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
                ),

                SizedBox(height: 20,),

                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 0) {
                        context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.month));
                      } else if (details.delta.dy < 0) {
                        context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.week));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            Image.asset("assets/swipe_rect.png", width: 60,),

                            SizedBox(height: 12,),

                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                  color: Color(0xFFEEEEEE)
                              ),
                            ),

                            SizedBox(height: 12,),

                            Image.asset("assets/courses_coach.png", width: MediaQuery.of(context).size.width - 40,),

                            SizedBox(height: 12,),

                            Image.asset("assets/food_coach.png", width: MediaQuery.of(context).size.width - 40,)
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
