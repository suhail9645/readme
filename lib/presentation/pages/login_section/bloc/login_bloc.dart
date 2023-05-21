import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:read_me/data/repository/check_admin.dart';
import 'package:read_me/data/repository/firebase_auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
   on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(LoginButtonClickedEvent event, Emitter<LoginState> emit)async {
    emit(LoginloadingState());
  bool isAdmin= CheckIfAdminImp().checkIfAdmin(event.email, event.password);
  if(isAdmin){
    emit(NavigateIntoAdminPageState());
  }else{
  final isUser=await  FirebaseUserOperationsimp().checkUser(event.email, event.password);
   isUser.fold((left) {
    emit(LoginError(error: left.error));
   }, (right) {
    emit(NavigateIntoHomePageState());
   });
  }
  }
}
