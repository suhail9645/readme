part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}


class EditProfileImageEvent extends EditProfileEvent{
  final ImageSource source;
  EditProfileImageEvent({required this.source});
}