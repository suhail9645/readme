part of 'file_bloc.dart';

@immutable
abstract class FileEvent {}

class FileInitialEvent extends FileEvent{}

class FileAddEvent extends FileEvent{}

class FileRemoveEvent extends FileEvent{
  final int index;
  FileRemoveEvent({required this.index});
}