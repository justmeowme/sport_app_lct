import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/user_bloc/user_event.dart';
import 'package:sport_app_lct/blocs/user_bloc/user_state.dart';

import '../../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<LoadUserEvent>(_onLoadUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  void _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final user = await userRepository.getCurrentUser();
      emit(UserLoadedState(user: user));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  void _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await userRepository.completeOnboarding(event.user);
      emit(UserLoadedState(user: event.user));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}