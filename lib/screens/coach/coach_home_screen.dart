import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/calendar_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final scheduleRepository = ScheduleRepository();
    final scheduleBloc = ScheduleBloc(scheduleRepository: scheduleRepository);

    scheduleBloc.add(LoadSchedules());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalendarBloc()),
        BlocProvider(create: (context) => scheduleBloc),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF202439),
        body: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {

            final calendarFormat = state is CalendarUpdated ? state.calendarFormat : CalendarFormat.week;
            final focusedDay = state is CalendarUpdated ? state.focusedDay : DateTime.now();
            final selectedDay = state is CalendarUpdated ? state.selectedDay : DateTime.now();

            return Column(
              children: [
                SizedBox(height: 56,),

                Header(text: DateFormat("yMMM", 'ru').format(DateTime.now()).toString(), textColor: Colors.white),

                SizedBox(height: 12,),

                CalendarWidget(),

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
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    color: Color(0xFFEEEEEE)
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat("dd/MM/yyyy", 'ru').format(selectedDay!).toString(),
                                      style: TextStyle(
                                          fontFamily: 'RussoOne',
                                          fontSize: 18
                                      ),
                                    ),
                                    Expanded(
                                      child: BlocBuilder<ScheduleBloc, ScheduleState>(
                                        builder: (context, state) {
                                          if (state is ScheduleLoading) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (state is ScheduleLoaded) {
                                            return ListView.builder(
                                              itemCount: state.schedules.length,
                                              itemBuilder: (context, index) {
                                                final schedule = state.schedules[index];
                                                return ScheduleWidget(
                                                  schedule: schedule,
                                                  forWho: 'client', // или 'coach' в зависимости от логики вашего приложения
                                                );
                                              },
                                            );
                                          } else if (state is ScheduleError) {
                                            return Center(child: Text("Ошибка: ${state.error}"));
                                          } else {
                                            return Container(); // Пустой контейнер для других состояний
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
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
