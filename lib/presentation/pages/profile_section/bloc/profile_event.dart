part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfilePageInitialEvent extends ProfileEvent{}


abstract class ProfileBodyEvent {}

class FavouriteBodyEvent extends ProfileBodyEvent{}

class DeleteFavouriteEvent extends ProfileBodyEvent{
  final Story favorite;
  final BuildContext context;
  DeleteFavouriteEvent({required this.favorite,required this.context});
}

class FileBodyEvent extends ProfileBodyEvent{}

class DeleteFileEvent extends ProfileBodyEvent{
  final int index;
  final BuildContext context;
  DeleteFileEvent({required this.context,required this.index});
}

