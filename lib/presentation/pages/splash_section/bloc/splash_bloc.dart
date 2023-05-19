
// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:read_me/data/repository/firebase_operatios_story.dart';
import 'package:read_me/data/repository/hive_operation.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitialEvent>(splashInitialEvent);
  }

  FutureOr<void> splashInitialEvent(SplashInitialEvent event, Emitter<SplashState> emit) async{
  String?value=await HiveOperationsImp().getUserDetailes();
     final data= await FirebaseStoryOperationsimp().getAllStory();
    if(value=='admin'){
       emit(NavigateIntoAdminPageFromSplash());
    }
    else if(value=='user'){
       emit(NavigateIntoHomeFromSplash());
    }else {
      emit(NavigateIntoLoginPageFromSplash());
    }
  
  
  }
}
