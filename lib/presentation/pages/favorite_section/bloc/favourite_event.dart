part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class FavoriteInitialEvent extends FavouriteEvent{}

class FavouriteRemoveEvent extends FavouriteEvent{
  final Story favorite;
  final BuildContext context;

  FavouriteRemoveEvent(this.favorite, this.context);
  
}