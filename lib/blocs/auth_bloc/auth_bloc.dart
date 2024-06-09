import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInEvent) {
      yield AuthLoading();
      try {
        final user = await authRepository.signIn(event.login, event.password);
        yield Authenticated(user: user);
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is SignUpEvent) {
      yield AuthLoading();
      try {
        final user = await authRepository.signUp(event.login, event.password);
        yield Authenticated(user: user);
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    }
  }
}
