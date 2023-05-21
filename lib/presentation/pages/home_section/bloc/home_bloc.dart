import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:read_me/data/repository/story_hive.dart';
import 'package:read_me/domain/model/model_story.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomePageInitalEvent>(homePageInitalEvent);
    on<NavigateIntoSearcPageEvent>(navigateIntoSearcPageEvent);
    on<BackIntoHomeEvent>(backIntoHomeEvent);
    on<CategoryItemClickedEvent>(categoryItemClickedEvent);
  }
  FutureOr<void> homePageInitalEvent(
      HomePageInitalEvent event, Emitter<HomeState> emit) async {
    List<Story> allStories =
        await StoryHiveOperationImp().getAllStoriesFromHive();
    emit(HomePageState(allStories: allStories, isHome: true));
  }

  FutureOr<void> navigateIntoSearcPageEvent(
      NavigateIntoSearcPageEvent event, Emitter<HomeState> emit) {
    emit(HomePageState(allStories: event.allStories, isHome: false));
  }

  FutureOr<void> backIntoHomeEvent(
      BackIntoHomeEvent event, Emitter<HomeState> emit) {
    emit(HomePageState(allStories: event.allStories, isHome: true));
  }

  FutureOr<void> categoryItemClickedEvent(
      CategoryItemClickedEvent event, Emitter<HomeState> emit) {
    emit(HomePageState(
        isHome: true,
        allStories: event.allStories,
        isCategoryList: event.isCategoryList,
        categoryName: event.categoryName));
       
  }
}
