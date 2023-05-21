import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/domain/model_file/model_file.dart';
import 'package:read_me/main.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc() : super(FileInitial(allFiles: const[])) {
    on<FileInitialEvent>(fileInitialEvent);
    on<FileAddEvent>(fileAddEvent);
    on<FileRemoveEvent>(fileRemoveEvent);
  }

  FutureOr<void> fileInitialEvent(FileInitialEvent event, Emitter<FileState> emit) async{
    List <FileCollection>allFiles=await GetAllFilesImp().getAllFiles();
    emit(FileInitial(allFiles: allFiles));
  }

  FutureOr<void> fileAddEvent(FileAddEvent event, Emitter<FileState> emit)async {
   await GetAllFilesImp().addFileIntoHive();
   fileBloc.add(FileInitialEvent());
  }

  FutureOr<void> fileRemoveEvent(FileRemoveEvent event, Emitter<FileState> emit)async {
    await GetAllFilesImp().deleteFile(event.index);
    fileBloc.add(FileInitialEvent());
  }
}
