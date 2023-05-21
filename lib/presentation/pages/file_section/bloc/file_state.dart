part of 'file_bloc.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {
  final List<FileCollection>allFiles;

  FileInitial({required this.allFiles});

}
