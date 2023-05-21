part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {
 
}
 class BottemItemClicked extends MainPageEvent{
  final int index;
  BottemItemClicked({required this.index});
 }
