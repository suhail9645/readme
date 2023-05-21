part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class ImageAddState extends AdminState{
final File?storyImage;
ImageAddState({required this.storyImage});
}