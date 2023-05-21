import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:read_me/data/repository/firestore_user.dart';
import 'package:read_me/domain/model_user.dart/model_user.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateUserDetailesEvent>(updateUserDetailesEvent);
  }

  FutureOr<void> updateUserDetailesEvent(UpdateUserDetailesEvent event, Emitter<EditProfileState> emit)async {
   await FireStoreUserImp().updateUserProfile(event.userData, event.context,event.extension, event.oldUser);
   emit(AfterUpdateProfileState());

  }
}
class EditProfileImageBloc extends Bloc<EditProfileImageEvent,EditProfileImage>{
  EditProfileImageBloc():super(EditProfileImage()){
   on<EditProfileImageEvent>((event, emit)async {
    final image = await ImagePicker().pickImage(source:event.source);
    File? updatedImage;
    if (image != null) {
       updatedImage=File(image.path);
       
    }
    emit(EditProfileImageState(updatedImage: updatedImage));
   });
  }
}