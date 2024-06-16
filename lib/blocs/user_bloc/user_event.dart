import '../../models/user.dart';

abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent({required this.user});
}
