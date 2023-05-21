part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class AfterUpdateProfileState extends EditProfileState{}

class EditProfileImage extends EditProfileState{}

class EditProfileImageState extends EditProfileImage{
 final File? updatedImage;
 EditProfileImageState({required this.updatedImage});
}