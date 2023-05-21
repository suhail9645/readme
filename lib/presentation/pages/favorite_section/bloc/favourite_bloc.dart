import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/domain/model/model_story.dart';
import 'package:read_me/main.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial(favouriteStories:const [])) {
    on<FavoriteInitialEvent>((event, emit)async {
   List<Story>favoriteStories=await  FavouriteHiveImp().getAllFavourite();
   emit(FavouriteInitial(favouriteStories: favoriteStories));
    });
    on<FavouriteRemoveEvent>((event, emit) {
          FavouriteHiveImp().addAndRemoveFavourite(event.favorite,event.context);
        favouriteBloc.add(FavoriteInitialEvent());
    });
  }
}
