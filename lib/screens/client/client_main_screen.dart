import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_watch/flutter_smart_watch.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_bloc.dart';
import 'package:sport_app_lct/blocs/auth_bloc/auth_event.dart';
import 'package:sport_app_lct/widgets/client_info_component.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar_bloc/calendar_bloc.dart';
import '../../blocs/calendar_bloc/calendar_event.dart';
import '../../blocs/calendar_bloc/calendar_state.dart';
import '../../repositories/shedule_repository.dart';
import '../../widgets/header.dart';
import '../auth/start_screen.dart';

class ClientMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalendarBloc()),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF202439),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            final focusedDay = state is CalendarUpdated ? state.focusedDay : DateTime.now();
            final selectedDay = state is CalendarUpdated ? state.selectedDay : DateTime.now();

            final calendarFormat = state is CalendarUpdated ? state.calendarFormat : CalendarFormat.week;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 56),
                  Header(text: DateFormat("yMMM", 'ru').format(kToday).toString(), textColor: Colors.white),
                  SizedBox(height: 12),
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
                  SizedBox(height: 20),
                  Container(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.delta.dy > 0) {
                          context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.month));
                        } else if (details.delta.dy < 0) {
                          context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.week));
                        }
                      },
                      onHorizontalDragUpdate: (details) {
                        if (details.delta.dx > 0) {
                          //do nothing
                        } else if (details.delta.dx < 0) {
                          //go to right screen
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Image.asset("assets/swipe_rect.png", width: 60),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Image.asset("assets/man_siluet.png", height: 450,),
                                    Spacer(),
                                    Column(
                                      children: [
                                        ClientInfoComponent(
                                            header: "За неделю",
                                            value: "12",
                                            value_description: "тренировок",
                                            onPress: (){
                                            }
                                        ),
                                        SizedBox(height: 12,),
                                        ClientInfoComponent(
                                            header: "Вес",
                                            value: "72",
                                            value_description: "кг",
                                            onPress: (){
                                            }
                                        ),
                                        SizedBox(height: 12,),
                                        ClientInfoComponent(
                                            header: "Калории",
                                            value: "260",
                                            value_description: "ккал",
                                            onPress: (){
                                            }
                                        ),
                                        SizedBox(height: 12,),
                                        ClientInfoComponent(
                                            header: "Вода",
                                            value: "4",
                                            value_description: "стакана",
                                            onPress: (){
                                            }
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12,),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Image.asset("assets/connect_watch.png", width: MediaQuery.of(context).size.width,),
                                ),
                                SizedBox(height: 64,)
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
