part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomePageInitalEvent extends HomeEvent {}

class NavigateIntoProfilePageEvent extends HomeEvent {}

class NavigateIntoSearcPageEvent extends HomeEvent {
  final List<Story> allStories;
  NavigateIntoSearcPageEvent({required this.allStories});
}

class RefreshButtonEvent extends HomeEvent {}

class NavigateIntoReadePage extends HomeEvent {}

class ChangeBodyIntoCategory extends HomeEvent {}

class BackIntoHomeEvent extends HomeEvent {
  final List<Story> allStories;
  BackIntoHomeEvent({required this.allStories});
}
class CategoryItemClickedEvent extends HomeEvent{
  final String categoryName;
  final List<Story> allStories;
  CategoryItemClickedEvent({required this.allStories, required this.categoryName});
}
