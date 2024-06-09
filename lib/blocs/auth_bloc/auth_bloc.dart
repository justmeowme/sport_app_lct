import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
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
}
