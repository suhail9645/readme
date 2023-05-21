import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/domain/model_file/model_file.dart';
import 'package:read_me/domain/model_user.dart/model_user.dart';
import 'package:read_me/main.dart';

import '../../../../domain/model/model_story.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilePageInitialEvent>(profilePageInitialEvent);
  }

  FutureOr<void> profilePageInitialEvent(ProfilePageInitialEvent event, Emitter<ProfileState> emit) async{
    final userProfile=await HiveUserProfileImp().getCurrentUserProfile();
    emit(ProfilePageInitialState(userData: userProfile));
      }
}

class ProfileBodyBloc extends Bloc<ProfileBodyEvent,ProfileBodyState>{
  ProfileBodyBloc():super(FavouriteBody(favoriteStories:const [])){
    on<FavouriteBodyEvent>(favouriteBodyEvent);
    on<FileBodyEvent>(fileBodyEvent);
    on<DeleteFavouriteEvent>(deleteFavouriteEvent);
    on<DeleteFileEvent>(deleteFileEvent);
  }

  FutureOr<void> favouriteBodyEvent(FavouriteBodyEvent event, Emitter<ProfileBodyState> emit) async{
    List<Story>favoriteStories=await FavouriteHiveImp().getAllFavourite();
    emit(FavouriteBody(favoriteStories: favoriteStories));
  }

  FutureOr<void> fileBodyEvent(FileBodyEvent event, Emitter<ProfileBodyState> emit)async {
    List<FileCollection>allFiles=await GetAllFilesImp().getAllFiles();
    emit(FileBody(allFiles: allFiles));

  }

  FutureOr<void> deleteFavouriteEvent(DeleteFavouriteEvent event, Emitter<ProfileBodyState> emit)async {
    await FavouriteHiveImp().addAndRemoveFavourite(event.favorite,event.context);
    profileBodyBloc.add(FavouriteBodyEvent());
  
  }


  FutureOr<void> deleteFileEvent(DeleteFileEvent event, Emitter<ProfileBodyState> emit) async{
    await GetAllFilesImp().deleteFileFromHive(event.index, event.context);
    profileBodyBloc.add(FileBodyEvent());
  
  }
}
