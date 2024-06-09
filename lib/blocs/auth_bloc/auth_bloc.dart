import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<CompleteOnboardingEvent>(_onCompleteOnboarding);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(event.login, event.password);
      print('User signed in: $user');
      emit(Authenticated(user: user));
    } catch (e) {
      print('Sign in error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(event.login, event.password);
      print('User signed up: $user');
      emit(Authenticated(user: user));
    } catch (e) {
      print('Sign up error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthService().removeToken();
      emit(AuthInitial());
    } catch (e) {
      print('Sign out error: $e');
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onCompleteOnboarding(CompleteOnboardingEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.completeOnboarding(event.user);
      emit(Authenticated(user: event.user));  // Убедитесь, что состояние изменяется на Authenticated
    } catch (e) {
      print('Complete onboarding error: $e');
      emit(AuthError(message: e.toString()));
    }
  }
}
