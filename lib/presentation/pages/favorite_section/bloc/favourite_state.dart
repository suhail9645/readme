part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {
  final List<Story>favouriteStories;
  FavouriteInitial({required this.favouriteStories});
}
