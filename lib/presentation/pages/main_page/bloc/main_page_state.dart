part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {}

class MainPageInitial extends MainPageState {
  final int index;
  MainPageInitial({required this.index});
}
