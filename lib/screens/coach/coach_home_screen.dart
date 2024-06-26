import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/models/shedule.dart';
import 'package:sport_app_lct/screens/courses/courses_list.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/training_text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar_bloc/calendar_bloc.dart';
import '../../blocs/calendar_bloc/calendar_state.dart';
import '../../blocs/calendar_bloc/calendar_event.dart';
import '../../blocs/shedule_bloc/shedule_bloc.dart';
import '../../blocs/shedule_bloc/shedule_event.dart';
import '../../blocs/shedule_bloc/shedule_state.dart';
import '../../repositories/shedule_repository.dart';
import '../../widgets/shedule_widget.dart';

class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleRepository = ScheduleRepository();
    final scheduleBloc = ScheduleBloc(scheduleRepository: scheduleRepository);
    scheduleBloc.add(LoadSchedules());

    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    TextStyle createTextStyle(Color color, String fontFamily) {
      return TextStyle(
        color: color,
        fontFamily: fontFamily,
      );
    }

    final commonTextStyle = createTextStyle(Colors.white, 'GilroyMedium');
    final outsideTextStyle = createTextStyle(const Color(0x50FFFFFF), 'GilroyMedium');
    final todayTextStyle = createTextStyle(const Color(0xFF202439), 'GilroyMedium');
    final selectedTextStyle = createTextStyle(Colors.white, 'GilroyMedium').copyWith(fontSize: 16);

    return Container(
      color: const Color(0xFF202439),
      child: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CalendarBloc()),
            BlocProvider(create: (context) => scheduleBloc),
          ],
          child: Scaffold(
            backgroundColor: const Color(0xFF202439),
            body: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                final selectedDay = state is CalendarUpdated ? state.selectedDay : DateTime.now();

                final calendarFormat = state is CalendarUpdated ? state.calendarFormat : CalendarFormat.week;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      Header(text: DateFormat("yMMM", 'ru').format(kToday).toString(), textColor: Colors.white),
                      const SizedBox(height: 12),
                      TableCalendar(
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: createTextStyle(Colors.white, 'RussoOne'),
                          weekendStyle: createTextStyle(Colors.white, 'RussoOne'),
                        ),
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: commonTextStyle,
                          weekendTextStyle: commonTextStyle,
                          outsideTextStyle: outsideTextStyle,
                          todayTextStyle: todayTextStyle,
                          todayDecoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
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
                      const SizedBox(height: 20),
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy > 0) {
                            context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.month));
                          } else if (details.delta.dy < 0) {
                            context.read<CalendarBloc>().add(FormatChangedEvent(format: CalendarFormat.week));
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Image.asset("assets/swipe_rect.png", width: 60),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat("dd/MM/yyyy", 'ru').format(selectedDay ?? DateTime.now()).toString(),
                                      style: const TextStyle(
                                          fontFamily: 'RussoOne',
                                          fontSize: 18
                                      ),
                                    ),
                                  ],
                                ),
                                BlocBuilder<ScheduleBloc, ScheduleState>(
                                  builder: (context, scheduleState) {
                                    if (scheduleState is ScheduleLoading) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (scheduleState is ScheduleLoaded) {
                                      final selectedDaySchedules = selectedDay == null ? <Shedule>[] : scheduleState.schedules.where((schedule) {
                                        final scheduleDate = DateTime.parse(schedule.date);
                                        return scheduleDate.year == selectedDay.year &&
                                            scheduleDate.month == selectedDay.month &&
                                            scheduleDate.day == selectedDay.day &&
                                            scheduleDate.isAfter(DateTime.now().subtract(const Duration(hours: 1)));
                                      }).toList();

                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width - 40,
                                          height: 150,
                                          child: selectedDaySchedules.isEmpty ? Center(child: TrainingTextContainer(selectedDay: selectedDay ?? kToday, kToday: kToday,)) : SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: selectedDaySchedules.length,
                                                    itemBuilder: (context, index) {
                                                      return ScheduleWidget(
                                                        schedule: selectedDaySchedules[index],
                                                        forWho: 'coach',
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )
                                          )
                                      );
                                    } else if (scheduleState is ScheduleError) {
                                      return const Center(child: Text('Ошибка загрузки расписания'));
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                const SizedBox(height: 12),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CoursesList()),
                                    );
                                  },
                                  child: Image.asset("assets/courses_coach.png", width: MediaQuery.of(context).size.width - 40),
                                ),

                                const SizedBox(height: 12),
                                Image.asset("assets/food_coach.png", width: MediaQuery.of(context).size.width - 40),
                              ],
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
        ),
      ),
    );
  }
}
