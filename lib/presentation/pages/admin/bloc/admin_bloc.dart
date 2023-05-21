import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:read_me/presentation/pages/admin/add_functions.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
class ImageAddBloc extends Bloc<ImageAddEvent,ImageAddState>{
  ImageAddBloc():super(ImageAddState(storyImage: null)){
    on((event, emit)async {
       File?image=await AddFunctions.addImage();
       emit(ImageAddState(storyImage: image));
    });
  }
}
