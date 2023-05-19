part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class NavigateIntoHomeFromSplash extends SplashState {}

class NavigateIntoAdminPageFromSplash extends SplashState {}

class NavigateIntoLoginPageFromSplash extends SplashState {}

class ErrorSplash extends SplashState {}
