import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/shedule_bloc/shedule_event.dart';
import 'package:sport_app_lct/blocs/shedule_bloc/shedule_state.dart';

import '../../repositories/shedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleInitial()) {
    on<LoadSchedules>(_onLoadSchedules);
  }

  void _onLoadSchedules(LoadSchedules event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    try {
      final schedules = await scheduleRepository.getSchedules();
      emit(ScheduleLoaded(schedules));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}
