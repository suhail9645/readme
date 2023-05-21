part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}


class EditProfileImageEvent extends EditProfileEvent{
  final ImageSource source;
  EditProfileImageEvent({required this.source});
}
class UpdateUserDetailesEvent extends EditProfileEvent{
  final UserData userData;
 final BuildContext context;
 final String extension;
 final String oldUser;

  UpdateUserDetailesEvent(this.userData, this.context, this.extension, this.oldUser);

}
