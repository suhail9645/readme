part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonClickedEvent({required this.email, required this.password});
}

class NavigateIntoRegisterEvent extends LoginEvent {}

class NavigateIntoAdminPageEvent extends LoginEvent {}
