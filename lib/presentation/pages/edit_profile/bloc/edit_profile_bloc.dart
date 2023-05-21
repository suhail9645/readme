import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
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