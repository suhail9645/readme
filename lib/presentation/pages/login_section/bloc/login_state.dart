part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginButtonClickedState extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}

class NavigateIntoRegisterState extends LoginState {}

class NavigateIntoAdminPageState extends LoginState {}

class NavigateIntoHomePageState extends LoginState {}
