part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfilePageInitialState extends ProfileState{
  final UserData userData;
  ProfilePageInitialState({required this.userData});
}

 class ProfileBodyState extends ProfileState {}

class FavouriteBody extends ProfileBodyState{
  final List<Story>favoriteStories;
  FavouriteBody({required this.favoriteStories});
}

class FileBody extends ProfileBodyState{
  final List<FileCollection>allFiles;
  FileBody({required this.allFiles});
}


