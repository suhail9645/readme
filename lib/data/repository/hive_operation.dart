import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/core/strings.dart';
import 'package:read_me/domain/model/model_story.dart';
import 'package:read_me/domain/model_file/model_file.dart';
import 'package:read_me/domain/repository/hive.dart';
import '../../domain/model_user.dart/model_user.dart';
import '../../presentation/pages/widgets/widgets.dart';

class HiveOperationsImp extends UserHiveOperations {
  @override
  Future<String?> getUserDetailes() async {
    final userDb = await Hive.openBox<String>(userHive);
    String? value = userDb.get(0);
    userDb.close();
    return value;
  }

  @override
  Future<void> addUserDatailes(String value) async {
    final userDb = await Hive.openBox<String>(userHive);
    userDb.put(0, value);
  }
}

class HiveUserProfileImp extends UserProfileHive {
  @override
  Future<void> addProfileIntoHIve(
      QueryDocumentSnapshot<Object?> userData) async {
    final userDb = await Hive.openBox<UserData>(userProfileHive);

    UserData user = UserData(
        uid: userData.id,
        userName: userData.get('userName'),
        fullName: userData.get('fullName'),
        imageUrl: userData.get('imageUrl'));

    await userDb.add(user);
  }

  @override
  Future<UserData> getCurrentUserProfile() async {
    final userDb = await Hive.openBox<UserData>(userProfileHive);
    return userDb.values.last;
  }
}

class FavouriteHiveImp extends FavouriteHive {
  @override
  Future<List<Story>> getAllFavourite() async {
    final storyDb = await Hive.openBox<Story>(storyHive);
    List<Story> storyList = storyDb.values.toList();

    List<Story> categoryStory = [];
    for (var element in storyList) {
      if (element.isFavorite) {
        categoryStory.add(element);
      }
    }
    return categoryStory;
  }

  @override
  Future<void> addAndRemoveFavourite(
      Story favorite, BuildContext context) async {
    final storyDb = await Hive.openBox<Story>(storyHive);

    favorite.isFavorite = !favorite.isFavorite;
    storyDb.put(favorite.id, favorite);
    if (favorite.isFavorite) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(contentText: 'successfully added in to favorite'));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(contentText: 'successfully removed from favorite'));
    }
  }
}

class GetAllFilesImp extends FileHive {
  @override
  Future<List<FileCollection>> getAllFiles() async {
    final fileDb = await Hive.openBox<FileCollection>(fileHive);
    return fileDb.values.toList();
  }

  @override
  Future<void> deleteFileFromHive(int index, BuildContext context) async {
    final fileDb = await Hive.openBox<FileCollection>(fileHive);
    fileDb.deleteAt(index);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackBar(contentText: 'file removed from readme'));
  }

  @override
  Future<void> addFileIntoHive() async {
    final fileDb = await Hive.openBox<FileCollection>(fileHive);
    final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'],
        allowMultiple: false,
        type: FileType.custom);
    if (result != null) {
      String extension = result.paths.first!.split('.').last;
      String name = result.names.first!;
      File pdf = File(result.files.first.path!);
      String date = DateTime.now().toString().split('.').first;
      if (extension.toLowerCase() == 'pdf') {
        final file = FileCollection(name, pdf.path, date);
        file.id = await fileDb.add(file);
        fileDb.put(file.id, file);
        //  Hive.close();
      }
    }
  }
  
  @override
  Future<void> deleteFile(int index)async {
   final fileDb = await Hive.openBox<FileCollection>(fileHive);
    fileDb.deleteAt(index);
  }
}
