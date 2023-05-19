part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class RefreshButtonState extends HomeState {}

// class  SearchPageState extends HomeState{}

class HomePageState extends HomeState {
  final List<Story> allStories;
  final bool isHome;
  final bool isCategoryList;
  final String categoryName;
  HomePageState({required this.isHome , required this.allStories,this.isCategoryList=false,this.categoryName=''});
}
