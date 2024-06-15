import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/user_bloc/user_event.dart';
import 'package:sport_app_lct/blocs/user_bloc/user_state.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<LoadUserEvent>(_onLoadUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<UploadUserIconEvent>(_onUploadUserIcon);
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

  void _onUploadUserIcon(UploadUserIconEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final iconUrl = await userRepository.uploadUserIcon(event.image);
      final currentUser = (state as UserLoadedState).user;
      final updatedUser = currentUser.copyWith(icon: iconUrl);
      await userRepository.completeOnboarding(updatedUser);
      emit(UserLoadedState(user: updatedUser));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}

class UploadUserIconEvent extends UserEvent {
  final File image;

  UploadUserIconEvent({required this.image});
}
